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
    if ! npx tsc --noEmit --skipLibCheck "$file"; then
        echo "Error: Syntax errors found in $file"
        exit 1
    fi
done

echo "All TypeScript files in 'src' directory passed syntax check."


# Install TypeScript locally without requiring administrative privileges
npm install typescript --prefix ./

# Compile TypeScript code
./node_modules/.bin/tsc || {
    echo "Error: Compilation of TypeScript code failed."
    exit 1
}

# Run npm install with error trapping
npm install --loglevel=error || {
    echo "Error: npm install failed."
    exit 1
}

# Check if index.html file exists
if [ ! -f "index.html" ]; then
    echo "Error: index.html file not found."
    exit 1
fi

# Check if the container with the same name exists and remove it if it does
docker ps -a --filter "name=typescript-tester-container" --format "{{.ID}}" | xargs -r docker rm -f

# Run the Docker container
docker run -d --name typescript-tester-container -p 7000:80 arm32v7/ubuntu:latest tail -f /dev/null

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
