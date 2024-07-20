#!/bin/bash

# Stop Colima
colima stop

# Uninstall Colima and Docker
brew uninstall colima docker docker-compose

# Remove Colima data
rm -rf ~/.colima

echo "Docker environment uninstalled and cleaned up."