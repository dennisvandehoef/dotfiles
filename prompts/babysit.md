/babysit

**Version:** 1.1.0

Bump semver when editing this prompt: **PATCH** — clarifications/typos, no behavior change; **MINOR** — new steps or stricter checks without breaking flows; **MAJOR** — phase reorder, changed DONE criteria, or breaking workflow assumptions.

# Babysit MR

Get the merge request for the **current branch** merge-ready on GitLab: feedback understood, work done, threads replied to, CI green, clean history.

**Workflow order:** preflight → read comments + build reply queue → work + commit → rebase if behind → push → verify → CI → reply in-thread. Do not post MR replies before fixes are pushed.

End every session with a single status line: `babysit v<version> — DONE: …` or `babysit v<version> — INCOMPLETE: …` (use **Version** above; match that number exactly; never both DONE and INCOMPLETE). Do not put the version in MR `> :robot:` replies — only on this final summary to the user.

---

## Context (do first)

| Item | How |
|------|-----|
| Branch | `BRANCH_NAME=$(git branch --show-current)` |
| MR IID | `glab mr view` or `glab mr view --output json \| jq -r .iid` |
| Pipeline | Link from MR or `glab ci view` |
| Base | `origin/staging` |
| Discussions (triage) | `glab mr note list <MR-ID> --state unresolved -F json` |
| Discussions (§4 / new) | `glab mr note list <MR-ID> --state all -F json` — find **new** threads only; never drop reply-queue IDs because they resolved |
| In-thread reply (preferred) | `glab mr note create "$MR_ID" --reply "$DISCUSSION_ID" -m "…"` — when `BABYSIT_REPLY_MODE=glab` (§0) |
| In-thread reply (fallback) | `glab api --method POST "projects/:id/merge_requests/${MR_ID}/discussions/${DISCUSSION_ID}/notes" -f body=…` — when `BABYSIT_REPLY_MODE=api` (§0); same auth as glab, no raw curl/token |
| MR note (last resort) | `glab api --method POST "projects/:id/merge_requests/${MR_ID}/notes" -f body=…` — **one** general MR note; does **not** open a new discussion thread (unlike `glab mr note create` without `--reply`) |

`glab mr note list` lists MR discussion threads (same data as `glab mr view --comments`). Each top-level JSON object is one thread; use its **`id`** (full ID or ≥8-char prefix) as `DISCUSSION_ID` for in-thread replies. Omit `<MR-ID>` on the current branch MR.

Read only what you need to act (comment bodies, failing job logs, relevant diffs). Do not dump full JSON payloads.

---

## 0. Preflight (required)

Run before reading comments or editing code:

```bash
git fetch origin
```

Detect how §4 posts in-thread replies (run after fetch succeeds). Capture help first — piping `glab` help directly into `grep` is unreliable on macOS (BSD `grep` treats `--reply` as a flag):

```bash
BABYSIT_GLAB_NOTE_HELP=$(glab mr note create --help 2>&1)
if printf '%s\n' "$BABYSIT_GLAB_NOTE_HELP" | grep -qF -e '--reply'; then
  BABYSIT_REPLY_MODE=glab
else
  BABYSIT_REPLY_MODE=api
fi
```

- **Success:** continue (to Resume if needed, then §1).
- **`BABYSIT_REPLY_MODE=api`:** continue — do **not** stop with INCOMPLETE solely because `--reply` is missing. Use the §4 `glab api` fallback. In the final user summary, note that glab lacks `--reply` and recommend `brew upgrade glab`.
- **Failure** (auth, network, permission): stop. Report **`INCOMPLETE: cannot reach origin`** with the error. Do **not** implement fixes, commit, or draft MR replies. Tell the user to fix credentials and re-run `babysit` from the repo — do not substitute a manual push/rebase checklist as your deliverable.

---

## Resume (prior incomplete run)

If `git status --porcelain` is non-empty at start (after preflight succeeds):

- Assume a prior babysit stopped mid-flight.
- Skip re-triage unless the MR has **new** unresolved threads since the last push.
- If §4 was skipped, **rebuild or complete the reply queue** from `glab mr note list` and post missing responses (in-thread per §0, or §4 last-resort MR note) — do not assume resolved threads were answered.
- Order: commit any remaining changes (§2b) → §2a if behind → §2c if needed → §3 push → verify → CI → §4.

---

## 1. Read comments (no replies yet)

Triage unresolved threads and build a **reply queue** of `discussion_id`s for §4. Two outputs: (A) what to fix, (B) which threads get an in-thread reply after push.

```bash
MR_ID=$(glab mr view --output json | jq -r .iid)   # or omit MR_ID on current branch MR

glab mr note list "$MR_ID" --state unresolved -F json
```

For each **unresolved** discussion:

1. Record **`discussion_id`** = `id`.
2. Read `notes[].body` (oldest → newest); note what is being asked.
3. Validate automated review (CodeRabbit, etc.) — valid fix vs. pushback vs. clarification only.
4. **Add `discussion_id` to the reply queue** when the thread needs any agent response after push:
   - code was changed (or will be) to address it
   - respectful disagreement / question back to reviewer
   - acknowledgment that the fix is pushed (even if a bot may auto-resolve later)

**Do not add to the reply queue** when no response is needed (e.g. pure praise, already answered in-thread by a human with no open ask).

**MR note fallback list** (§4 last resort): also track `discussion_id`s (or a single `global` entry) when a response is needed but **does not belong in one thread** — e.g. whole-MR rebase/CI fixes, cross-cutting changes, or feedback that is not tied to a specific diff discussion. Do **not** force an in-thread reply on the wrong thread.

**Do not post replies in §1.** Build a short plan: which comments need code changes, which need clarification only — keyed by `discussion_id`; which belong on the MR note fallback list.

**Reply queue is authoritative for §4.** If CodeRabbit (or anyone) resolves a queued thread during §2–§3, **still reply** in §4 in-thread — resolved threads accept new notes. Never drop queue IDs because resolution changed.

Fallback if `note list` is unavailable: `glab mr view "$MR_ID" --comments --unresolved` for triage; still build the reply queue from what you read.

---

## 2. Work

### 2a. Rebase onto staging (only if needed)

Preflight already ran `git fetch origin`. Check whether the branch is behind `origin/staging`:

```bash
git merge-base --is-ancestor origin/staging HEAD && echo "up to date — skip rebase" || echo "behind — rebase needed"
```

- If **up to date** (command succeeds): skip rebase; go to 2b.
- If **behind**: rebase (push happens in §3, not here):

```bash
git rebase origin/staging
```

If 2a was skipped but CI failures look unrelated to this MR, re-check whether the branch is behind `staging` and rebase if it is.

### 2b. Fix CI and implement comment feedback

- Inspect failing jobs from the pipeline URL.
- Fix generators, lint, tests — whatever failed **within this MR's scope**.
- Implement valid feedback from §1.
- **Do not** change CI config or workflows just to make failures pass; if that would be required, stop and report **`INCOMPLETE: CI config change required`**.
- After each logical fix batch: `git add` scoped paths → `git commit` with a clear message (or `git commit --amend` only when amending the tip commit per §2c).
- **Never finish with unstaged or uncommitted changes.** Before §3, run `git status --porcelain`; if non-empty, commit or revert — do not proceed to §4.

### 2c. Clean history (if you made temp commits)

You may use intermediate commits while working, but **before §3** remove WIP, debug, or throwaway commits. No interactive rebase (`git rebase -i` is not available).

Pick one approach:

1. **Amend** — fix belongs on the tip commit only.
2. **Fixup / autosquash** — keep original MR commits; during work: `git commit --fixup=<hash>`; then:
   ```bash
   GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash origin/staging
   ```
3. **Soft reset** — only when collapsing to a single fix commit is acceptable: `git reset --soft origin/staging`, then one commit with real fixes.

---

## 3. Push and watch pipeline

After §2c history cleanup, **always** push:

```bash
git push origin "$BRANCH_NAME" --force-with-lease
```

- If push fails: report **`INCOMPLETE: push failed`** with the error. Do not post MR replies or mark done.

**Post-push verification** (must pass before §4):

```bash
git status --porcelain                    # must be empty
git rev-list "origin/$BRANCH_NAME"..HEAD  # must be empty
```

If either check fails: **`INCOMPLETE: local changes or unpushed commits remain`** — fix before continuing.

Watch the pipeline until **green** or **blocked**. If blocked or still failing after push, report **`INCOMPLETE: CI <state>`** with pipeline link and failing job — do not claim done.

---

## 4. Respond to comments (in-thread)

**Skip §4** unless preflight passed, §3 push succeeded, post-push verification is clean, and CI is green or reported blocked.

### Pre-reply refresh

Before posting, run:

```bash
glab mr note list "$MR_ID" --state all -F json
```

- **Add** any **new** unresolved discussions not already on the reply queue (reviewer posted while you were working).
- **Do not remove** queue entries because `resolved: true` — bot auto-resolve after fixes is expected.
- Skip a queue ID only if the thread already has your in-thread reply with `> :robot: Generated by cursor` from this babysit run (avoid duplicates).

### Thread model

- **One in-thread reply per `discussion_id` on the reply queue** (unless it is on the MR note fallback list from §1) — loop the queue; each gets its own in-thread reply via §0 `BABYSIT_REPLY_MODE` (or re-detect if glab was upgraded mid-run).
- **Reply even if the thread is resolved** when it is on the queue (typical after CodeRabbit auto-resolve post-fix).
- **MR note fallback list:** skip in-thread for those IDs during the loop; cover them in the single last-resort MR note below.
- **Never** use `glab mr note create -m "…"` without `--reply` for feedback — that uses the Discussions API and opens a **new** thread. Last resort uses the **Notes** API (`…/merge_requests/${MR_ID}/notes`) instead.
- **Never** use raw curl or hand-built GitLab API calls when `glab mr note create --reply`, `glab api` discussion notes, or `glab api` MR notes can post.
- Do **not** provide "suggested reply bodies" for the user to paste when push did not happen.

Message content (all paths):

- What changed, or respectful disagreement / question.
- Reference commits or the pipeline when relevant so reviewers see the fix landed first.
- **Every** agent-written message **must always** end with: `> :robot: Generated by cursor`.

### Primary: `glab mr note create --reply` (when `BABYSIT_REPLY_MODE=glab`)

Repeat per queue ID:

```bash
glab mr note create "$MR_ID" \
  --reply "$DISCUSSION_ID" \
  -m "$(cat <<'EOF'
<short reply: what changed, or why pushback / need clarification>
<optional: commit SHAs, pipeline link>

> :robot: Generated by cursor
EOF
)"
```

If `--reply` is missing at runtime despite §0, switch to the fallback below for remaining queue IDs.

### Fallback: `glab api` (when `BABYSIT_REPLY_MODE=api` or `--reply` unavailable)

Repeat per queue ID. `:id` resolves from the current git repo (same as other `glab api` usage):

```bash
glab api --method POST \
  "projects/:id/merge_requests/${MR_ID}/discussions/${DISCUSSION_ID}/notes" \
  -f "body=$(cat <<'EOF'
<short reply: what changed, or why pushback / need clarification>
<optional: commit SHAs, pipeline link>

> :robot: Generated by cursor
EOF
)"
```

### Last resort: MR note (no new discussion thread)

Use when **any** of these apply after the in-thread loop:

- In-thread primary **and** discussion `glab api` fallback both failed for one or more queue IDs.
- The response is on the **MR note fallback list** (§1) — changes or answers that do not fit a single thread.

Post **at most one** MR note per babysit run. Consolidate all affected `discussion_id`s (prefix + one line each) in the body. Do **not** call `glab mr note create` without `--reply` — that opens new threads.

```bash
glab api --method POST \
  "projects/:id/merge_requests/${MR_ID}/notes" \
  -f "body=$(cat <<'EOF'
<short summary: what changed, pipeline link, commit SHAs if relevant>

Per discussion (in-thread reply unavailable or not thread-specific):
- <discussion-id-prefix>: <what you did or why>
- …

> :robot: Generated by cursor
EOF
)"
```

- Skip this if every queue ID already has an in-thread reply and nothing is on the MR note fallback list.
- If this POST also fails: **`INCOMPLETE: could not post MR note or in-thread reply`** with errors and remaining `discussion_id`s.

### Failure

If in-thread and last-resort MR note both fail for any required response, report **`INCOMPLETE: could not post in-thread reply or MR note`** with `discussion_id`(s) and error output.

**Completion check:** before `DONE`, every reply-queue `discussion_id` has either (a) an in-thread reply (`--reply` or discussion `glab api`), or (b) coverage in the single last-resort MR note with its ID called out. If any are missing, report **`INCOMPLETE: N threads without reply or MR note coverage`** with discussion IDs or snippets.

---

## Anti-patterns

- Do **not** end with "What you still do" / bash snippets for the user when you could not push.
- Do **not** claim local verification (lint/tests) as completion without green remote CI.
- Do **not** tell the user to "re-run babysit" without stating **`INCOMPLETE`** and why.
- Do **not** leave fixes only in the working tree.
- Do **not** reply with one top-level comment covering multiple threads **while in-thread still works** — except the single §4 last-resort MR note (`…/notes` API) when in-thread failed or the item is on the MR note fallback list.
- Do **not** skip §4 replies because a thread was auto-resolved by CodeRabbit or marked resolved before you replied.
- Do **not** filter §4 on `--state unresolved` only — use the **reply queue**.
- Do **not** use `glab mr note create -m "…"` without `--reply` when answering reviewer feedback — use in-thread paths or the §4 MR note (`…/notes`) last resort, not a new discussion thread.
- Do **not** improvise raw GitLab API/curl when `glab api` (discussion or MR notes) or `glab mr note create --reply` can post.
- Do **not** post §4 replies before §3 push succeeds.
- Do **not** omit `babysit v<version> —` on the final status line to the user.

---

## Git constraints

- **NEVER** `git merge`.
- Only this MR's commits may be rewritten; **never** rewrite commits that already exist on `origin/staging`.
- **MUST** use `--force-with-lease` when force-pushing (never bare `--force`).
- Final branch history: original MR commits plus commits that fix real problems only — no WIP/debug/throwaway commits.

---

## Definition of done

Every item must be true; any failure = **`INCOMPLETE`**, not done.

- [ ] `git fetch origin` succeeded at start (§0)
- [ ] All unresolved threads read and triaged at §1; **reply queue** and **MR note fallback list** built where needed
- [ ] `git status --porcelain` empty
- [ ] `git rev-list "origin/$BRANCH_NAME"..HEAD` empty (all commits on remote)
- [ ] Branch up to date with `origin/staging` (rebased only if it was behind)
- [ ] CI green, or blocked with a clear reason reported
- [ ] History clean (no temp commits)
- [ ] Every **reply-queue** thread is answered after push: in-thread (`--reply` or discussion `glab api`) **or** covered in the single last-resort MR note (`…/notes`); signature on every agent-written GitLab message
- [ ] Summary starts with `babysit v<version> —` then **DONE** (what changed, pipeline link) or **INCOMPLETE: …** — never both; version matches **Version** above
