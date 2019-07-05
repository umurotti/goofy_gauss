#!/bin/bash
if [ "list" == "$1" ]
then
	echo $(( $(ps r | wc -l) - 1))
elif [ 1 == $1 ]
then
	ps
else
	echo "wrong"
fi

for i in {1..50}
do
	echo -n "-"
done
echo

if [ "write" == "$2" ]
then
	ps > psInfo
	echo "write succesfull"
else
	echo "do not write"
fi
