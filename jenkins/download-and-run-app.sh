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
npm install typescript --prefix ./

# Debugging
echo "Current directory: $(pwd)"
echo "Node modules: $(ls -l node_modules)"
echo "Compiling TypeScript code..."
./node_modules/.bin/tsc   # Compile TypeScript code
echo "Compilation finished."

# Check if index.html file exists
if [ ! -f "index.html" ]; then
    echo "Error: index.html file not found."
    exit 1
fi

# Check if the container with the same name exists and remove it if it does
docker ps -a --filter "name=typescript-tester-container" --format "{{.ID}}" | xargs docker rm -f

# Run the Docker container
docker run -d --name typescript-tester-container -p 7000:80 arm32v7/ubuntu:latest tail -f /dev/null

# Install Apache web server inside the container
docker exec -it typescript-tester-container apt-get update
docker exec -it typescript-tester-container apt-get install -y apache2

# Create a directory for hosting the TypeScript app
docker exec -it typescript-tester-container mkdir -p /var/www/html

# Wait for Apache to start
sleep 2

# Copy the index.html file into the container
docker cp index.html typescript-tester-container:/var/www/html/index.html

# Restart Apache to apply changes
docker exec -it typescript-tester-container service apache2 restart

echo "Apache web server installed and TypeScript app hosted on port 7000."

# Check if the container is running and on the correct port
container_info=$(docker ps -a --filter "name=typescript-tester-container" --format "{{.Names}} {{.Ports}}")

if [[ -n "$container_info" ]]; then
    if [[ "$container_info" != *"7000->7000"* ]]; then
        echo "Container is running but not on port 7000:7000. Stopping and restarting with correct port..."
        docker stop typescript-tester-container
        docker rm typescript-tester-container
        docker run -d --name typescript-tester-container -p 7000:7000 arm32v7/ubuntu:latest tail -f /dev/null
    else
        echo "Container is running and on port 7000:7000. No action needed."
    fi
else
    echo "Container is not running. Starting it..."
    docker run -d --name typescript-tester-container -p 7000:7000 arm32v7/ubuntu:latest tail -f /dev/null
fi

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
