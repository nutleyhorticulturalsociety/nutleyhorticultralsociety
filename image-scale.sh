#!/bin/sh
FILES="site/images/originals/garden_visits_4/*"
mkdir "site/images/garden_visits_4"
mkdir "site/images/garden_visits_4/icon"

touch image.html
 echo "<html><head></head><body>" >>image.html
for f in $FILES
do
  #test to see that we are only have files, no directorys
  if [ -f "$f" ] 
  then
  	echo "Processing file... $f\n"
  	path=${f%/*}
  	echo "path is:"$path"\n"
  	file="${f##*/}"
  	echo "file is:"$file"\n"
  	base="${file%%.*}"
  	base=`echo $base | tr "[\-| ]" "_"`
  	echo "base filenane is:"$base"\n"
  	ext="${file#*.}"
  	echo "extension is:"$ext"\n"
  	echo "saving:$path$base_scaled.$ext\n"
  	convert  -resize 90x90 "$f" "site/images/garden_visits_4/icon/"$base"_90x90.$ext"
  	convert  -resize 600 "$f" "site/images/garden_visits_4/"$base"_600.$ext"
  	echo "<a href='#'><img src='images/garden_visits_4/"$base"_600.$ext' alt='Garden vistit' height='350' width='600' /></a>" >> image.html
  fi
  
done


