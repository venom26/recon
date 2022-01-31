#!/bin/bash
for i in $(cat $2)
do
	sr=$1
	echo "${sr//%FUZZ%/$i}" >> fuzz-replaced.txt
done
