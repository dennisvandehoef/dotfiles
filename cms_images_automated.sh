orgdir=$(pwd)

cd ~/code/kp/cms/scripts/

./image_optimizer.sh


cd ~/code/kp/cms/

# remove bugged files
git status | grep .tmp | xargs rm

for dir in app/assets/images/designs/*/
do
    dir=${dir%*/}
    dirName=${dir##*/}

    count=`git status | grep $dir/ | wc -l`
    if [[ $count -ne 0 ]] ; then
      git status | grep $dir | sed 's/modified://' | xargs git add
      git commit -m "Minified images for design: $dirName"
      echo '------------------------------'
    fi
done

for dir in app/cells/*/
do
    dir=${dir%*/}
    dirName=${dir##*/}

    count=`git status | grep $dir/ | wc -l`
    if [[ $count -ne 0 ]] ; then
      git status | grep $dir | sed 's/modified://' | xargs git add
      git commit -m "Minified images for cell: $dirName"
      echo '------------------------------'
    fi
done

cd $orgdir
