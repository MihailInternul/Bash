#!/bin/bash

#Write bash script accepting operation parameter (“-”, “+”, “*”, “%”), sequence of numbers and debug flag. For example:
# ./your_script.sh -o % -n 5 3 -d > Result: 2
# ./your_script.sh -o + -n 3 5 7 -d > Result: 15
# If -d flag is passed, script must print additional information:
# User: <username of the user running the script>
# Script: <script name>        
# Operation: <operation>
# Numbers: <all space-separated numbers>

# Function to display debug information
print_debug_info() {
    echo "User: $(whoami)"
    echo "Script: $0"
    echo "Operation: $operation"
    echo "Numbers: ${numbers[@]}"
}

# Parse command line arguments
while getopts ":o:n:d" opt; do
  case $opt in
    o)
      operation=$OPTARG
      ;;
    n)
      shift $((OPTIND-2))
      numbers=("$@")
      break
      ;;
    d)
      debug=true
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

# Perform the specified operation
case $operation in
    +)
        result=0
        for num in "${numbers[@]}"; do
            result=$((result + num))
        done
        ;;
    -)
        result=${numbers[0]}
        for ((i=1; i<${#numbers[@]}; i++)); do
            result=$((result - numbers[i]))
        done
        ;;
    *)
        echo "Invalid operation: $operation"
        exit 1
        ;;
esac

# Display result
if [ "$debug" = true ]; then
    print_debug_info
fi

echo "Result: $result"
