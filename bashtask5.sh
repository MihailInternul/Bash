#!/bin/bash

# Write script with following functionality:
# If -v tag is passed, replaces lowercase characters with uppercase and vise versa
# If -s is passed, script substitutes <A_WORD> with <B_WORD> in text (case sensitive)
# If -r is passed, script reverses text lines
# If -l is passed, script converts all the text to lower case
# If -u is passed, script converts all the text to upper case
# Script should work with -i <input file> -o <output file> tags


# Parse command line arguments
while getopts ":i:o:vsrlu" opt; do
  case $opt in
    i)
      input_file=$OPTARG
      ;;
    o)
      output_file=$OPTARG
      ;;
    v)
      reverse_case=true
      ;;
    s)
      substitute=true
      substitute_string=$OPTARG
      replacement_string=${@:$OPTIND:1}
      ;;
    r)
      reverse_lines=true
      ;;
    l)
      convert_lowercase=true
      ;;
    u)
      convert_uppercase=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done

# Check if both input and output files are provided
if [[ -z $input_file || -z $output_file ]]; then
    echo "Usage: $0 -i <input file> -o <output file> [-vsrlu]"
    exit 1
fi

# Read input file content
content=$(<"$input_file")

# Perform requested transformations
if [ "$reverse_case" = true ]; then
    content=$(echo "$content" | tr '[:lower:][:upper:]' '[:upper:][:lower:]')
fi

if [ "$substitute" = true ]; then
    content=$(echo "$content" | sed "s/$substitute_string/$replacement_string/g")
fi

if [ "$reverse_lines" = true ]; then
    content=$(echo "$content" | tac)
fi

if [ "$convert_lowercase" = true ]; then
    content=$(echo "$content" | tr '[:upper:]' '[:lower:]')
fi

if [ "$convert_uppercase" = true ]; then
    content=$(echo "$content" | tr '[:lower:]' '[:upper:]')
fi

# Write to output file
echo "$content" > "$output_file"

echo "Transformation completed. Output written to: $output_file"
