#!/bin/bash
echo "name, cpp1, cpp2, ..."

cat >Makefile <<end
all: $1

end

if [ ! "$2" == "base" ]
then
	echo "true"
else
	echo "false"
fi

str=""
for var in "${@:3}"
do
	file=`basename "$var" .cpp`
	str="$str $file.o "
done

echo $1: $str >> Makefile
echo -e "\tg++" $str "-o" $1 >> Makefile

for var in "${@:3}"
do
	file=`basename "$var" .cpp`
	echo $var
	if [ "$var" == "main.cpp" ] && [ ! "$2" == "base" ]
	then
		echo "if"
		echo -e -n "$file.o: " "$var" "\n\tg++ -std=c++$2 -c " "$var" "\n" >> Makefile
	else
		echo -e -n "$file.o: " "$var" "\n\tg++ -c " "$var" "\n" >> Makefile
	fi
done

echo "clean:" >> Makefile
echo -e "\t rm -rf *.o " $1 >> Makefile