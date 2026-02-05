#!/bin/bash

mkdir -p ~/secure_vault

echo "Welcome to the Keys Vault." > ~/secure_vault/keys.txt
echo "Welcome to the Secrets Vault." > ~/secure_vault/secrets.txt
echo "Vault Log File Initialized." > ~/secure_vault/logs.txt

echo "Vault Setup Complete!"
ls -l ~/secure_vault
