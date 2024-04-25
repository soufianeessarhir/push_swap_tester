#!/bin/bash

count=0

while [ $count -lt 100000 ]
do
    test=$(seq 1 500 | sort -R)
    result=$(./push_swap $test | wc -l)
    if [ $result -gt 5500 ]
    then
        echo "Result $result is greater than 5500, in case $test"
		break
    fi
	   echo "$count    Result  $result  "
    ((count++))
done