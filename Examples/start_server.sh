#!/bin/bash

# Variables
SERVER_DIR="$HOME/server_dir_name"           # Change this to the directory you created earlier
MEMORY_SETTINGS="-Xmx1024M -Xms1024M"        # Adjust based on your server's requirements

# Start the server in a detached screen session
screen -dmS Minecraft_Server bash -c "cd \"$SERVER_DIR\" && java $MEMORY_SETTINGS -jar server.jar nogui"

echo "Minecraft server started in screen session 'Minecraft_Server'."
