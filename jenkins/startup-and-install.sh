#!/bin/bash

# Check if the container already exists and running
if docker ps -a --format '{{.Names}}' | grep -q "typescript-tester-container"; then
    echo "Container 'typescript-tester-container' already exists."

    # Check if the container is running
    if docker ps --format '{{.Names}}' | grep -q "typescript-tester-container"; then
        echo "Container is running, using existing container..."
        CONTAINER_ID=$(docker ps --format '{{.ID}}' --filter "name=typescript-tester-container")
    else
        echo "Container is not running, starting it..."
        docker start typescript-tester-container
        CONTAINER_ID=$(docker ps --format '{{.ID}}' --filter "name=typescript-tester-container")
    fi
else
    echo "Container 'typescript-tester-container' does not exist, creating it..."
    docker run --rm -d --name typescript-tester-container --privileged --entrypoint /bin/bash arm32v7/ubuntu:latest
    CONTAINER_ID=$(docker ps --format '{{.ID}}' --filter "name=typescript-tester-container")
fi

# Install necessary packages if they are not installed
echo "Installing necessary packages..."
docker exec $CONTAINER_ID bash -c 'which node npm python3 pip3 tsc curl wget' > /dev/null 2>&1
if [ $? -ne 0 ]; then
    docker exec $CONTAINER_ID bash -c 'apt-get update && \
        apt-get install -y nodejs npm python3 python3-pip curl wget && \
        npm install -g npm@latest && \
        pip3 install unittest2 coverage && \
        npm install -g typescript'
else
    echo "Necessary packages are already installed."
fi

# Print OS version
echo "OS Version:"
docker exec $CONTAINER_ID cat /etc/os-release

# Print Node.js version
echo "Node.js Version:"
docker exec $CONTAINER_ID node -v

# Print npm version
echo "npm Version:"
docker exec $CONTAINER_ID npm -v

# Print Python version
echo "Python Version:"
docker exec $CONTAINER_ID python3 --version

# Print unittest version
echo "unittest Version:"
docker exec $CONTAINER_ID python3 -m unittest --version

# Print coverage version
echo "coverage Version:"
docker exec $CONTAINER_ID coverage --version

# Print Docker image ID
echo "Docker Image ID:"
docker exec $CONTAINER_ID cat /proc/self/cgroup | grep "docker" | sed 's/^.*\///' | head -n 1
