#!/bin/bash

for ((i=1; i<=100; i++)); do
    # Check for multiples of 3 and 5 first
    if ((i % 3 == 0)) && ((i % 5 == 0)); then
        echo "FizzBuzz"
    elif ((i % 3 == 0)); then
        echo "Fizz"
    elif ((i % 5 == 0)); then
        echo "Buzz"
    else
        echo "$i"
    fi
done
