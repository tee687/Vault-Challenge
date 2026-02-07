#!/bin/bash

# Function to update permissions
update_permission() {
    local file=$1
    local default_perm=$2

    echo "--- Checking $file ---"
    ls -l "$file"

    read -p "Do you want to update permissions for $file? (yes/no): " choice
    
    if [[ "$choice" == "yes" ]]; then
        read -p "Enter new permission (e.g., 600): " new_perm
        # If user presses Enter (empty input), use default
        if [[ -z "$new_perm" ]]; then
            chmod "$default_perm" "$file"
            echo "Applied default permission: $default_perm"
        else
            chmod "$new_perm" "$file"
            echo "Applied new permission: $new_perm"
        fi
    else
        echo "Keeping current permissions for $file."
    fi
    echo ""
}

# 1. Check if secure_vault directory exists
if [[ ! -d "secure_vault" ]]; then
    echo "Error: secure_vault directory does not exist."
    exit 1
fi

# Move into the directory to work on files
cd secure_vault

# 2. Call function for each file with its specific default
update_permission "keys.txt" "600"
update_permission "secrets.txt" "640"
update_permission "logs.txt" "644"

# 3. Final display
echo "Final Permissions for Vault Files:"
ls -l keys.txt secrets.txt logs.txt

