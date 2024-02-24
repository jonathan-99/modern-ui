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
    echo "Installing necessary packages..."
  docker exec $CONTAINER_ID bash -c 'which node' > /dev/null 2>&1 || docker exec $CONTAINER_ID apt-get install -y nodejs
  docker exec $CONTAINER_ID bash -c 'which npm' > /dev/null 2>&1 || docker exec $CONTAINER_ID apt-get install -y npm
  docker exec $CONTAINER_ID bash -c 'which python3' > /dev/null 2>&1 || docker exec $CONTAINER_ID apt-get install -y python3
  docker exec $CONTAINER_ID bash -c 'which pip3' > /dev/null 2>&1 || docker exec $CONTAINER_ID apt-get install -y python3-pip
  docker exec $CONTAINER_ID bash -c 'which tsc' > /dev/null 2>&1 || docker exec $CONTAINER_ID apt-get install -y typescript
  docker exec $CONTAINER_ID bash -c 'which curl' > /dev/null 2>&1 || docker exec $CONTAINER_ID apt-get install -y curl
  docker exec $CONTAINER_ID bash -c 'which wget' > /dev/null 2>&1 || docker exec $CONTAINER_ID apt-get install -y wget
  docker exec $CONTAINER_ID bash -c 'which npm' > /dev/null 2>&1 || docker exec $CONTAINER_ID npm install -g npm@latest
  docker exec $CONTAINER_ID bash -c 'which pip3' > /dev/null 2>&1 || docker exec $CONTAINER_ID pip3 install unittest2 coverage
else
    echo "Necessary packages are already installed."

    # Update npm to the latest version
    docker exec $CONTAINER_ID bash -c 'npm install -g npm@latest'
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
docker exec $CONTAINER_ID python3 -m unittest

# Print coverage version
echo "coverage Version:"
docker exec $CONTAINER_ID coverage --version

# Print Docker image ID
echo "Docker Image ID:"
docker exec $CONTAINER_ID cat /proc/self/cgroup | grep "docker" | sed 's/^.*\///' | head -n 1
