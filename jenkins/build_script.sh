#!/bin/bash

node -v
npm -v

sudo visudo

# Check if nodejs is installed
if ! command -v node &> /dev/null; then
    # Install nodejs
    sudo apt update
    sudo apt install nodejs
fi

# Try installing TypeScript globally
echo "Trying to install TypeScript globally..."
npm install -g typescript || {
    echo "Failed to install TypeScript globally. Trying local installation..."
    npm install typescript --save-dev || {
        echo "Failed to install TypeScript locally as well. Exiting."
        exit 1
    }
}

# Try installing TypeScript globally
echo "Trying to install TypeScript globally..."
npm install -g typescript || {
    echo "Failed to install TypeScript globally. Trying local installation..."
    npm install typescript --save-dev || {
        echo "Failed to install TypeScript locally as well. Exiting."
        exit 1
    }
}

# Compile TypeScript code
echo "Compiling TypeScript code..."
ls -la || { echo "Failed to list contents of $repoDir"; exit 1; }
tsc --build tsconfig.json --listEmittedFiles --verbose 2>&1 | tee "build.log" || { echo "Failed to compile TypeScript code"; exit 1; }
cat "build.log" || { echo "Failed to display compilation log"; exit 1; }

# Run the application (if applicable)
# echo "Running the application..."
# ./gradlew bootRun || { echo "Failed to run the application"; exit 1; }

