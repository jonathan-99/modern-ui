#!/bin/bash

# Function to check if Docker container is running
container_running() {
    docker ps --filter "name=typescript-tester-container" --format '{{.Names}}' | grep -q "typescript-tester-container"
}

# Function to display installation issues
display_installation_issues() {
    local container_id=$1
    docker exec "$container_id" cat /var/log/apt/history.log
}

# Function to check if Docker container is already running
container_running() {
    docker ps -q --filter "name=typescript-tester-container" | grep -q . && return 0 || return 1
}

# Check if Docker container is already running
if ! container_running; then
    echo "Docker container 'typescript-tester-container' is not running. Starting it now..."
    # Run the Docker container
    container_id=$(docker run -d --name typescript-tester-container arm32v7/ubuntu:latest /bin/bash -c "tail -f /dev/null")
    if [ $? -ne 0 ]; then
        echo "Error: Failed to start Docker container."
        exit 1
    fi

    # Install Apache inside the container
    echo "Installing Apache inside the container..."
    docker exec $container_id bash -c "apt-get update && apt-get install -y apache2"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Apache inside the container."
        exit 1
    fi
fi

# Assign the container ID to $CONTAINER_ID
container_id=$(docker ps --format '{{.ID}}' --filter "name=typescript-tester-container")

# Debug: Check if the container ID is set correctly
echo "Container ID: $container_id"

# Install Git in the Docker container
echo "Installing Git..."
docker exec $container_id apt-get update
docker exec $container_id apt-get install -y git

# Clone git repo containing TypeScript files
echo "Cloning git repo containing TypeScript files..."
docker exec $container_id git clone https://github.com/jonathan-99/modern-ui modern-ui

# List files in the 'src' directory
docker exec $container_id ls -l modern-ui/src


# Check if the 'src' directory exists
echo "Checking if 'src' directory exists..."
docker exec $container_id bash -c '[ -d "modern-ui/src" ] && echo "src directory exists" || echo "src directory does not exist"'

# Find all TypeScript files in the 'src' directory
echo "Finding TypeScript files in 'src' directory..."
docker exec $container_id find modern-ui/src -name "*.ts"

# Check each TypeScript file for syntax errors
for file in $ts_files; do
    echo "Checking syntax errors in $file..."
    if ! docker exec $container_id npx tsc --noEmit --skipLibCheck "$file" 2>&1; then
        echo "Error: Syntax errors found in $file"
        exit 1
    fi
done


docker exec typescript-tester-container env

# Run the TypeScript compiler with the --showConfig flag
echo "Running TypeScript compiler with --showConfig flag..."
npx tsc --showConfig

# If the compilation fails, exit with an error message
if [ $? -ne 0 ]; then
    echo "Error: Compilation of TypeScript code failed."
    exit 1
fi

echo "All TypeScript files in 'src' directory passed syntax check."


# Install TypeScript locally without requiring administrative privileges
npm install typescript --prefix ./

# Compile TypeScript code
./node_modules/.bin/tsc || {
    echo "Error: Compilation of TypeScript code failed, but the build process will continue."
}

# Check if index.html file exists
if [ ! -f "index.html" ]; then
    echo "Error: index.html file not found."
    exit 1
fi

# Check if the container with the same name exists and remove it if it does
docker ps -a --filter "name=typescript-tester-container" --format "{{.ID}}" | xargs -r docker rm -f

# Run the Docker container
container_id=$(docker run -d --name typescript-tester-container -p 7000:80 arm32v7/ubuntu:latest tail -f /dev/null)

# Check if the container is running
if [ -z "$container_id" ]; then
    echo "Error: Docker container failed to start."
    exit 1
fi

echo "waiting..."
# Wait for the app to start
sleep 10

# Wait for Apache to start
echo "Waiting for Apache to start..."
docker exec typescript-tester-container service apache2 status

# Check if there were any installation issues
echo "Checking for installation issues..."
display_installation_issues "typescript-tester-container"

# Check if the app is up
echo "Checking if the application is up..."
if curl -sSf http://localhost:7000 > /dev/null; then
    echo "Application is up and running!"
else
    echo "Error: Application is not running on port 7000."
    exit 1
fi

# Try to display Apache error log, if exists
echo "Trying to display Apache error log..."
docker exec typescript-tester-container bash -c 'cat /var/log/apache2/error.log' || {
    echo "Error: Failed to display Apache error log."
}
