#!/bin/bash

fib() {
    local n=$1

    if [ $n -eq 0 ]; then
        echo 0
    elif [ $n -eq 1 ]; then
        echo 1
    else
        local a=0
        local b=1
        local result=0

        for ((i=2; i<=$n; i++)); do
            result=$((a + b))
            a=$b
            b=$result
        done

        echo $result
    fi
}

# Test the function
n_values=(0 1 2 3 4 5 6 7 8 9 10)
for n in "${n_values[@]}"; do
    result=$(fib "$n")
    echo "Fibonacci($n) = $result"
done

