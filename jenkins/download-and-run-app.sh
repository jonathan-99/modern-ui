#!/bin/bash

# Function to check if Docker container is running
container_running() {
    docker ps --filter "name=typescript-tester-container" --format '{{.Names}}' | grep -q "typescript-tester-container"
}

# Check if Docker container is already running
if ! container_running; then
    echo "Docker container 'typescript-tester-container' is not running. Starting it now..."
    # Run the Docker container
    docker run -d --name typescript-tester-container arm32v7/ubuntu:latest tail -f /dev/null
fi

# Clone git repo containing TypeScript files
if [ -d "typescript-files" ]; then
    rm -rf typescript-files
fi
# Clone git repo containing TypeScript files
git clone https://github.com/jonathan-99/modern-ui typescript-files

# Enter the cloned directory
cd typescript-files || exit

# Install TypeScript locally without requiring administrative privileges
npm install typescript --no-save

# Compile TypeScript code
./node_modules/.bin/tsc   # Compile TypeScript code

# Run unittests
# Run unittests
python3 -m unittest discover -s testing -p 'test_*.tsx'

# Run coverage report
coverage run -m unittest discover -s testing -p 'test_*.tsx'
coverage report -m

# Run Docker container on host port 7000
docker run -it --rm --name typescript-tester-container -p 7000:7000 arm32v7/ubuntu:latest

# Wait for the app to start
sleep 5

# Check if the app is up
echo "Checking if the application is up..."
if curl -sSf http://localhost:7000 > /dev/null; then
    echo "Application is up and running!"
else
    echo "Error: Application is not running on port 7000."
    exit 1
fi
