#!/bin/bash

# Download and run the Docker container
docker run -it --rm --name typescript-tester-container --privileged --entrypoint /bin/bash arm32v7/ubuntu:latest <<EOF
# Update apt and install necessary packages
apt-get update
apt-get install -y nodejs npm python3 python3-pip
npm install -g npm@latest
pip3 install unittest2 coverage
npm install -g typescript


# Print OS version
echo "OS Version:"
cat /etc/os-release

# Print Node.js version
echo "Node.js Version:"
node -v

# Print npm version
echo "npm Version:"
npm -v

# Print Python version
echo "Python Version:"
python3 --version

# Print unittest version
echo "unittest Version:"
python3 -m unittest --version

# Print coverage version
echo "coverage Version:"
coverage --version

# Print Docker image ID
echo "Docker Image ID:"
cat /proc/self/cgroup | grep "docker" | sed 's/^.*\///' | head -n 1
EOF
