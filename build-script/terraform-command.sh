#!/bin/bash

# Check if LocalStack is running
if ! nc -z localhost 4566 >/dev/null 2>&1; then
    echo "Error: LocalStack is not running. Please start LocalStack first."
    exit 1
fi

# Set AWS environment variables for LocalStack
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1

# Define directories to process
directories=(
    "layout/aws-vpc"
    "layout/aws-asg"
)

# Function to execute terraform commands
execute_terraform() {
    local dir=$1
    local command=$2

    echo "Executing terraform $command in $dir"
    terraform -chdir="$dir" init
    if [ "$command" != "init" ]; then
        terraform -chdir="$dir" $command -auto-approve
    fi
}

# Main execution
command=$1

if [ -z "$command" ]; then
    echo "Usage: $0 <command>"
    echo "Commands: init, plan, apply, destroy"
    exit 1
fi

# Process each directory
for dir in "${directories[@]}"; do
    case $command in
        "init"|"plan"|"apply"|"destroy")
            execute_terraform "$dir" "$command"
            ;;
        *)
            echo "Invalid command. Use: init, plan, apply, or destroy"
            exit 1
            ;;
    esac
done