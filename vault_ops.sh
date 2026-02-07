#!/bin/bash

# Ensure we are in the correct directory
cd secure_vault 2>/dev/null || { echo "Error: secure_vault not found"; exit 1; }

while true; do
    echo "--- Vault Operations Menu ---"
    echo "1. Add Secret"
    echo "2. Update Secret"
    echo "3. Add Log Entry"
    echo "4. Access Keys"
    echo "5. Exit"
    read -p "Choose an option [1-5]: " choice

    case $choice in
        1)
            read -p "Enter new secret: " secret
            echo "$secret" >> secrets.txt
            echo "Secret added."
            ;;
        2)
            read -p "Enter existing secret to replace: " old
            read -p "Enter new secret: " new
            # Check if the secret exists first
            if grep -q "$old" secrets.txt; then
                sed -i "s/$old/$new/g" secrets.txt
                echo "Secret updated."
            else
                echo "No match found."
            fi
            ;;
        3)
            read -p "Enter log message: " message
            timestamp=$(date "+%Y-%m-%d %H:%M:%S")
            echo "[$timestamp] $message" >> logs.txt
            echo "Log entry added."
            ;;
        4)
            echo "ACCESS DENIED 🚫"
            ;;
        5)
            echo "Exiting vault..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    echo ""
done

