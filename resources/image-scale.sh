#!/bin/sh
#the folder that the full size pictures are stored in
DIR="../../../Pictures/originals/*"

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
		mkdir "../images/${d##*/}"
		echo "making directory site/images/${d##*/}"
		for subd in $SUBDIR
			do
			#if it is a directory
			echo "Processing directory... $subd\n"
			if [ -d "$subd" ]
				then

				#make the directory we are going to put the scaled images in
				mkdir "../images/${d##*/}/${subd##*/}"

				#make the directory we are going to put the icons in
				mkdir "../images/${d##*/}/${subd##*/}/icon"

				echo "making directory site/images/${d##*/}/${subd##*/}"
				FILES="$subd/*"

				section=`echo ${d##*/} | tr "[_]" " "`
				sub_section=`echo ${subd##*/} | tr "[_]" " "`

				echo "<h1>$section : $sub_section</h1>" >> image.html

				echo "<div id="${d##*/}${subd##*/}" class="nivoo-slider">" >> image.html


				for f in $FILES
					do
				 	if [ -f "$f" ]
				 		then
				  		echo "Processing file... $f\n"
				  		path=${f%/*}
				  		echo "path is:"$path"\n"
				  		file="${f##*/}"
				  		echo "file is:"$file"\n"
			  			base="${f%.*}"
				  		base=`echo $base | tr "[\-| ]" "_"`
				  		echo "base filenane is:"$base"\n"
				  		ext="${f##*.}"
				  		echo "extension is:"$ext"\n"
						filename="${file%.*}"
						echo "filename is:"$filename"\n"



						#if we have an image
						if [ $ext = "jpg" ] || [ $ext = "JPG" ] ;
							then
				  			echo "../images/${d##*/}/${subd##*/}/"$filename"_600.$ext"

				  			convert  -resize 90x90 "$f" "../images/${d##*/}/${subd##*/}/icon/"$filename"_90x90.$ext"
				  			convert  -resize 600 "$f" "../images/${d##*/}/${subd##*/}/"$filename"_600.$ext"
				  			echo "<a href='#'><img src='images/${d##*/}/${subd##*/}/"$filename"_600.$ext' alt='${d##*/} ${subd##*/}' height='350' width='600' /></a>" >> image.html
						fi

					fi
				done
				echo "</div>" >> image.html
			fi

		done

	fi


done
