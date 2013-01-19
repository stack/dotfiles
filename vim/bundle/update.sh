#!/bin/sh

for file in *
do
  if [ -d $file ]; then
    cd $file
    git pull origin master
    cd ..
  fi
done

