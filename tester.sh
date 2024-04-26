#!/bin/bash

count=0

while [ $count -lt 1000 ] #you can change the numbe of tests by changing the value "1000" int the while "increace the value for mor tests an vice versa"
do
    test=$(seq 1 500 | sort -R) #you can change the size of the numbers list here by modefy the range (1 500) for 100 number use (1 100) or any range that have 100 numbers
    result=$(./push_swap $test | wc -l)
    if [ $result -gt 5500 ] #you can change the number of max instractions here by modefy the value (5500) for 500 number use 5500, for 100 use 700 ,5 use 12 ,3 use 2
    then
        echo "Result $result is greater than 5500, in case $test"
		break #you can remove break to not stop at first fail
    fi
	   echo "$count    Result  $result  "
    ((count++))
done
	echo "change the script to run other tests (3 5 100 500) follow the comments above"