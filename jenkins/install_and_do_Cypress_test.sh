#!/bin/bash

# Pull Docker image for Raspberry Pi
docker pull balenalib/raspberry-pi-debian-node:latest

# Install required packages inside Docker container
docker run --rm -it -v $(pwd):/usr/src/app balenalib/raspberry-pi-debian-node:latest /bin/bash -c '
    # Update package list
    apt-get update

    # Install required packages
    apt-get install -y \
        openjdk-11-jre-headless \
        curl \
        wget

    # Install Node.js and npm
    curl -sL https://deb.nodesource.com/setup_14.x | bash -
    apt-get install -y nodejs

    # Install Cypress
    npm install -g cypress
'

# Confirm installation
echo "Cypress installed successfully."
