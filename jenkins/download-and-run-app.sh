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


# Check if the typescript-files directory already exists and remove it if it does
if [ -d "typescript-files" ]; then
    echo "Removing existing typescript-files directory..."
    rm -rf typescript-files
fi

# Clone git repo containing TypeScript files
git clone https://github.com/jonathan-99/modern-ui typescript-files

# Enter the cloned directory
cd typescript-files || exit

# Check if the 'src' directory exists
if [ ! -d "src" ]; then
    echo "Error: 'src' directory not found."
    exit 1
fi

# Find all TypeScript files in the 'src' directory
ts_files=$(find src -name "*.ts")

# Check each TypeScript file for syntax errors
for file in $ts_files; do
    echo "Checking syntax errors in $file..."
    if ! npx tsc --noEmit --skipLibCheck "$file" 2>&1; then
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
