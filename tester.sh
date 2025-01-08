#!/bin/bash

# Function to test push_swap with given sequence
test_push_swap() {
    local sequence="$1"
    local max_instructions="$2"
    
    result=$(./push_swap $sequence | wc -l)
    
    if [ $result -gt $max_instructions ]; then
        echo "Failed: $result instructions (max: $max_instructions)"
        echo "Sequence: $sequence"
        return 1
    else
        echo "Pass: $result instructions"
        return 0
    fi
}

# Generate permutations using factorial numbering system
generate_unique_perm() {
    local size="$1"
    local nums=($(seq 1 $size))
    local indices=($(seq 0 $((size-1))))
    
    # Fisher-Yates shuffle for initial randomization
    for ((i = size - 1; i > 0; i--)); do
        j=$((RANDOM % (i + 1)))
        # Swap
        temp=${nums[i]}
        nums[i]=${nums[j]}
        nums[j]=$temp
    done
    
    echo "${nums[@]}"
}

# Main testing function
run_tests() {
    local size="$1"
    local max_instructions="$2"
    local num_tests="$3"
    local count=0
    local failed=0
    
    echo "Testing sequences of size $size (max $max_instructions instructions)"
    echo "Running $num_tests tests..."
    
    while [ $count -lt $num_tests ]; do
        sequence=$(generate_unique_perm $size)
        
        if ! test_push_swap "$sequence" "$max_instructions"; then
            ((failed++))
            echo "Failed test $((count+1))"
            break  # Remove this line to continue after failures
        fi
        
        ((count++))
        echo "Completed test $count/$num_tests"
    done
    
    if [ $failed -eq 0 ]; then
        echo "All tests passed!"
    else
        echo "$failed tests failed"
    fi
}

# Test configurations
declare -A configs
configs[3]=2    # 3 numbers: max 2 instructions
configs[5]=12   # 5 numbers: max 12 instructions
configs[100]=700  # 100 numbers: max 700 instructions
configs[500]=5500 # 500 numbers: max 5500 instructions

# Ask user which test to run
echo "Select test size:"
echo "1) 3 numbers"
echo "2) 5 numbers"
echo "3) 100 numbers"
echo "4) 500 numbers"
read -p "Enter choice (1-4): " choice

case $choice in
    1) size=3;;
    2) size=5;;
    3) size=100;;
    4) size=500;;
    *) echo "Invalid choice"; exit 1;;
esac

read -p "Number of tests to run (default 1000): " num_tests
num_tests=${num_tests:-1000}

run_tests $size ${configs[$size]} $num_tests
