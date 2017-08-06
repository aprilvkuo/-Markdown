#!bin/sh
for file in ./*
do
	if test -d $file
	then
		for file1 in ./ ${file}/*
		do
			cp $file1 "../${file##*/}_${file1##*/}"
		done
	fi
done
