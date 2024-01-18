#!/bin/bash

usage() {
    echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
    exit 1
}

# Parse command line arguments
while getopts ":s:i:o:" opt; do
    case $opt in
        s)
            shift_value=$OPTARG
            ;;
        i)
            input_file=$OPTARG
            ;;
        o)
            output_file=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            usage
            ;;
    esac
done

# Check if all required parameters are provided
if [[ -z $shift_value || -z $input_file || -z $output_file ]]; then
    usage
fi

# Validate that shift_value is a number
if ! [[ $shift_value =~ ^[0-9]+$ ]]; then
    echo "Error: Shift value must be a non-negative integer."
    usage
fi

# Perform Caesar cipher encryption
tr '[A-Za-z]' "$(printf %s {A..Z} {a..z} | sed "s/./&$shift_value/" | tr -d '\n')" < "$input_file" > "$output_file"

echo "Caesar cipher encryption completed. Output written to: $output_file"

