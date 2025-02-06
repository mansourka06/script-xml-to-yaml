#!/bin/bash

# Usage check: require an input file and an output file.
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_file output_file"
    exit 1
fi

input_file="$1"
output_file="$2"

# Write the YAML header to the output file.
echo "items:" > "$output_file"

# Use grep to extract all <add .../> elements and then process each one.
grep -o '<add key="[^"]*" value="[^"]*" */>' "$input_file" | while read -r line; do
    # Extract the key using sed.
    key=$(echo "$line" | sed -E 's/.*key="([^"]*)".*/\1/')
    # Extract the value using sed.
    value=$(echo "$line" | sed -E 's/.*value="([^"]*)".*/\1/')
    
    # Append the YAML item to the output file.
    echo "- key: $key" >> "$output_file"
    echo "  value: \"$value\"" >> "$output_file"
done

echo "YAML file written to $output_file"
