#!/bin/bash

# Install Homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Colima
brew install colima

# Install Docker CLI
brew install docker
brew install docker-compose

# Start Colima
colima start

echo "Docker environment setup complete. Use 'colima start' and 'colima stop' to manage the Docker runtime."