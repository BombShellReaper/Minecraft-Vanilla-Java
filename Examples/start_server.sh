#!/bin/bash

# Variables
SERVER_DIR="$HOME/server_dir_name"    # Replace "server_dir_name" with the directory you made earlier.
MEMORY_SETTINGS="-Xmx3G -Xms1G"       # Rpelace "3G" & "1G" with what ever you want the max and min RAM set to.
SCREEN_NAME="Minecraft_Server"        # Replace "Minecrafy_Server" with whatever you'd like.

# Start the server in a detached screen session
screen -dmS ${SCREEN_NAME} bash -c "cd ${SERVER_DIR} && java ${MEMORY_SETTINGS} -jar server.jar nogui"

echo "Minecraft server started in screen session 'Minecraft_Server'."
