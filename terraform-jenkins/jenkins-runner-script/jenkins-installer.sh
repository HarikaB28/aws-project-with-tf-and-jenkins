#!/bin/bash

set -x

# Force apt to run completely silently and automate all yes/no responses
export DEBIAN_FRONTEND=noninteractive

# 1. Update the system package cache
sudo apt update -y

# 2. Install Java (Jenkins requirement) and Unzip
sudo apt install openjdk-21-jdk-headless unzip -y

# 3. Securely fetch the updated, valid Jenkins GPG Key 
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# 4. Add the Jenkins package source repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# 5. Refresh your package lists to discover the newly added Jenkins repo
sudo apt update -y

# 6. Install the authenticated Jenkins package
sudo apt install jenkins -y

# 7. Start and enable Jenkins service
sudo systemctl enable --now jenkins

# 8. Download and Install the Correct (64-bit amd64) Terraform version
cd /tmp
wget https://hashicorp.com
unzip terraform_1.6.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Clean up temporary downloads
rm -f terraform_1.6.5_linux_amd64.zip

