#!/bin/sh
DIR="site/images/originals/*"

rm image.html
touch image.html
 echo "<html><head></head><body>" >>image.html

for d in $DIR
do
	#if it is a directory	
	if [ -d "$d" ]
		then
		echo "Processing directory... $d\n"
		#find the sub directories
		SUBDIR="$d/*"

		#make the directory we are going to put the scaled images in
		mkdir "site/images/${d##*/}"
		echo "making directory site/images/${d##*/}" 
		for subd in $SUBDIR
			do
			#if it is a directory
			echo "Processing directory... $subd\n"	
			if [ -d "$subd" ]
				then

				#make the directory we are going to put the scaled images in
				mkdir "site/images/${d##*/}/${subd##*/}"

				#make the directory we are going to put the icons in
				mkdir "site/images/${d##*/}/${subd##*/}/icon"

				echo "making directory site/images/${d##*/}/${subd##*/}"
				FILES="$subd/*"

				echo "<h1>${d##*/} ${subd##*/}</h1>" >> image.html

				echo "<div id="Slider" class="nivoo-slider">" >> image.html


				for f in $FILES 
					do
				 	if [ -f "$f" ] 
				 		then
				  		echo "Processing file... $f\n"
				  		path=${f%/*}
				  		echo "path is:"$path"\n"
				  		file="${f##*/}"
				  		echo "file is:"$file"\n"
			  			base="${f%%.*}"
				  		base=`echo $base | tr "[\-| ]" "_"`
				  		echo "base filenane is:"$base"\n"
				  		ext="${f#*.}"
				  		echo "extension is:"$ext"\n"
						
						#if we have an image
						if [ $ext = "jpg" ]
							then
				  			echo "saving:$path$base_scaled.$ext\n"
						
				  			convert  -resize 90x90 "$f" "site/images/${d##*/}/${subd##*/}/icon/"$file"_90x90.$ext"
				  			convert  -resize 600 "$f" "site/images/${d##*/}/${subd##*/}/"$file"_600.$ext"
				  			echo "<a href='#'><img src='images/${d##*/}/${subd##*/}/"$file"_600.$ext' alt='${d##*/} ${subd##*/}' height='350' width='600' /></a>" >> image.html
						fi
						
					fi
				done
				echo "</div>" >> image.html
			fi	
			
		done
			
	fi


done




