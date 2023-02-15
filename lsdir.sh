#!/bin/bash
function lsdir(){
    for file in `ls $1`
    do
		if [ -d $1/$file ]; then
	    	lsdir $1/$file
		else
			echo "$1/$file"
		fi
  	done
}
lsdir $1
