#!/bin/bash

# Download and execute the Ubuntu Umbrel Bitcoin Node install script from your GitHub account

# Specify the version of the Ubuntu Umbrel Bitcoin Node install script
UMBREL_VERSION=v0.3.11

# Specify your GitHub username
GITHUB_USERNAME=invest-master

# Specify the URL of the Ubuntu Umbrel Bitcoin Node install script on your GitHub account
UMBREL_INSTALL_SCRIPT_URL=https://github.com/${GITHUB_USERNAME}/ubuntu-Umbrel-Bitcoin-Node-Installer/releases/download/${UMBREL_VERSION}/umbrel-install.sh

# Specify the filename to save the Ubuntu Umbrel Bitcoin Node install script as
UMBREL_INSTALL_SCRIPT=umbrel-install.sh

# Download the Ubuntu Umbrel Bitcoin Node install script from your GitHub account
curl -L ${UMBREL_INSTALL_SCRIPT_URL} -o ${UMBREL_INSTALL_SCRIPT}

# Make the Ubuntu Umbrel Bitcoin Node install script executable
chmod +x ${UMBREL_INSTALL_SCRIPT}

# Run the Ubuntu Umbrel Bitcoin Node install script
./${UMBREL_INSTALL_SCRIPT}
