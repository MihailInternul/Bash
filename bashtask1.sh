#!/bin/bash

# The Fibonacci numbers are the numbers in the following integer sequence. 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, …….. In mathematical terms, the sequence Fn of Fibonacci numbers is defined by the recurrence relation Fn = Fn-1 + Fn-2 with seed values F0 = 0 and F1 = 1. Write a function fib that returns Fn. For example:
# if n = 0, then fib should return 0
# if n = 1, then it should return 1
# if n > 1, it should return Fn-1 + Fn-2

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

