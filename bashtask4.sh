#!/bin/bash

usage() {
    echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
    exit 1
}

validate_input_file() {
    if [ ! -f "$input_file" ]; then
        echo "Error: Input file '$input_file' not found."
        usage
    fi
}

validate_shift_value() {
    if ! [[ $shift_value =~ ^[0-9]+$ ]]; then
        echo "Error: Shift value must be a non-negative integer."
        usage
    fi
}

perform_caesar_cipher() {
    alphabet=$(printf %s {A..Z} {a..z})
    if [ $shift_value -lt 0 ]; then
        shift_value=$(( (shift_value % 26 + 26) % 26 ))  # Ensure positive shift for negative values
    fi
    shifted_alphabet=$(echo "$alphabet" | tr "A-Za-z" "$(echo "$alphabet" | cut -c${shift_value}-)$(echo "$alphabet" | cut -c1-$((shift_value - 1)))")
    tr '[A-Za-z]' "$shifted_alphabet" < "$input_file" > "$output_file"
}


check_empty_input() {
    if [ ! -s "$output_file" ]; then
        echo "Error: Input file is empty or does not contain any alphabetic characters."
        exit 1
    fi
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

# Validate input file existence
validate_input_file

# Validate shift value
validate_shift_value

# Perform Caesar cipher encryption
perform_caesar_cipher

# Check for empty input file
check_empty_input

echo "Caesar cipher encryption completed. Output written to: $output_file"
