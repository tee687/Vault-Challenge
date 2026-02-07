#!/bin/bash

# Define the target directory and report path
VAULT_DIR="secure_vault"
REPORT="$VAULT_DIR/vault_report.txt"

# Ensure the vault exists
if [[ ! -d "$VAULT_DIR" ]]; then
    echo "Error: $VAULT_DIR not found."
    exit 1
fi

# Clear existing report or create a new one
echo "--- Vault Security Report ---" > "$REPORT"
echo "Generated on: $(date)" >> "$REPORT"
echo "----------------------------" >> "$REPORT"

# Loop through every file in the vault
for file in "$VAULT_DIR"/*; do
    if [[ -f "$file" ]]; then
        # Extract metadata
        filename=$(basename "$file")
        size=$(stat -c %s "$file")
        mod_date=$(stat -c %y "$file")
        perms=$(stat -c %a "$file")

        # Write data to report
        {
            echo "File: $filename"
            echo "Size: $size bytes"
            echo "Modified: $mod_date"
            echo "Permissions: $perms"
        } >> "$REPORT"

        # Security check: if permissions are higher than 644
        # We use -gt (greater than) for numeric comparison
        if [ "$perms" -gt 644 ]; then
            echo "⚠️ SECURITY RISK DETECTED" >> "$REPORT"
        fi
        
        echo "----------------------------" >> "$REPORT"
    fi
done

echo "Audit complete. Report created at: $REPORT"

