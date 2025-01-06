#!/bin/bash

# Variables
SERVER_DIR="$HOME/server_dir_name"    # Replace "server_dir_name" with your server directory.
MEMORY_SETTINGS="-Xmx3G -Xms1G"       # Adjust "3G" and "1G" for max and min RAM.
SCREEN_NAME="Minecraft_Server"        # Replace "Minecraft_Server" with your preferred name.
JAR_FILE="server.jar"                 # Ensure this matches the name of your server jar file.

# Check if the server directory exists
if [ ! -d "$SERVER_DIR" ]; then
    echo "Error: Server directory '$SERVER_DIR' does not exist."
    exit 1
fi

# Check if the server JAR file exists
if [ ! -f "${SERVER_DIR}/${JAR_FILE}" ]; then
    echo "Error: JAR file '${JAR_FILE}' not found in '${SERVER_DIR}'."
    exit 1
fi

# Start the server in a detached screen session
screen -dmS ${SCREEN_NAME} bash -c "cd ${SERVER_DIR} && java ${MEMORY_SETTINGS} -jar ${JAR_FILE} nogui"

# Confirmation message
if screen -list | grep -q "${SCREEN_NAME}"; then
    echo "Minecraft server started in screen session '${SCREEN_NAME}'."
else
    echo "Error: Failed to start the Minecraft server."
fi
