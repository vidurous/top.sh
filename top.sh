#!/bin/bash
DATE=`date +%d-%b-%Y-%R`
compare="0.10"

CHECK1() {
    export check1=$(cat /proc/loadavg | awk '{print $1}')
}

CHECK2() {
    export check2=$(cat /proc/loadavg | awk '{print $2}')
}

CHECK3() {
    export check3=$(cat /proc/loadavg | awk '{print $3}')
}

COMPARE1() {
    export compare1=$(echo "$check1 $compare" | awk '{print ($1 > $2)}')
}

COMPARE2() {
    export compare2=$(echo "$check2 $compare" | awk '{print ($1 > $2)}')
}

COMPARE3() {
    export compare3=$(echo "$check3 $compare" | awk '{print ($1 > $2)}')
}

CHECK1; CHECK2; CHECK3; COMPARE1; COMPARE2; COMPARE3

if [[ $compare1 -eq 1 ]] || [[ $compare2 -eq 1 ]] || [[ $compare3 -eq 1 ]] ; then 
    
    printf "\n Collection Metric:\n" >> loadavg.txt
    printf " $DATE \n" >> loadavg.txt
    printf " Top starts\n" >> loadavg.txt
    printf " \n" >> loadavg.txt
    top -b -o %CPU -n 1 >> loadavg.txt
    exit 0

else 
    echo "No high usage found" && exit 1 
fi
