# Setting Up a Dedicated Minecraft (Vanilla) Server

## **Overview**

- This is a step-by-step guide on how to set up and run a Factorio server.

## **Prerequisites**

This guide is not intended for complete beginners to Linux or server administration. It assumes the following:

 - Basic knowledge of Linux: You should be comfortable using the terminal (command line), understanding file system paths, and basic Linux commands like cd, ls, mkdir, and cp.
 - Basic networking understanding: Familiarity with concepts like IP addresses, ports, and SSH will help as you configure remote access to your server.
 - Experience with server setup: You should have some experience setting up and managing servers. This includes installing packages, configuring firewalls, and understanding security practices like disabling 
  root login.
 - Access to a Linux server: You should have a VPS or dedicated server with a fresh installation of a supported Linux distribution (Ubuntu or Debian recommended).
 - Root or Sudo privileges: You need to be able to execute administrative commands (with sudo or as root) on the server.
 - If you are not familiar with these concepts, you may want to spend some time with basic Linux tutorials before proceeding. This guide will walk you through the setup step-by-step, but we won’t be able to 
  cover fundamental Linux concepts in detail. You can find helpful resources online, such as the Linux Foundation’s tutorials, or consider following beginner guides for server setup.

> [!Caution]
> Directory structures may differ based on your specific setup. Always check paths and ensure you're working in the correct directories to avoid issues.

# Step 1: Update and Upgrade Your System
> Keep your system up-to-date by running the following command:

    sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y

# Step 2: Install Required Dependencies 
    
### 1. Install Screen (Session Manager)
> Screen allows you to manage terminal sessions:

    sudo apt install screen -y

### 2. Install Java
> Java is required to run the Minecraft server:

    sudo apt install openjdk-21-jdk-headless

### 3. Install Nano (Text Editor)
> Nano is a simple text editor for editing files:

    sudo apt install nano

### 4. Install OpenSSH Server
> OpenSSH enables secure remote access to your server:

    sudo apt install openssh-server -y

> [!NOTE]
> This enables secure remote access to your server.

### 5. Install UFW (Uncomplicated Firewall)
> UFW simplifies managing firewall rules:

    sudo apt install ufw -y

# Step 3: Configure UFW (Uncomplicated Firewall)

### 1. Allow Minecraft Server Port (25565)
> This is the default port used by Minecraft servers:

    sudo ufw allow from any to any port 25565 comment "Minecraft Server Port"

> [!TIP]
> For improved security, restrict access to only trusted IP addresses.

### 2. Allow SSH Connections (Optional)
> If managing your server remotely, allow SSH traffic (port 22):

    sudo ufw allow from any to any port 22 comment "SSH"

> [!TIP]
> For improved security, restrict access to only trusted IP addresses.

### 3. Set Default Rules (Optional)
> Deny all incoming traffic by default:

    sudo ufw default deny incoming

### 4. Enable UFW
> Activate the firewall:

    sudo ufw enable
    
--------------------------------------------------------------------------------
# Step 4: Create a Non Sudo User

### 1. Add a New User
> Replace your_username with your desired username:

    sudo adduser your_username

> [!NOTE]
> This will prompt you through the setup

### 2. Reboot the System
> Restart your system to ensure all changes take effect:

    sudo reboot

-------------------------------------------------------------------------------
# Step 5: Download the Minecraft Dedicated Server Files & Set-Up

**Log in to your server with the new user account through cmd, PowerShell, PuTTY, etc. Use your preferred terminal emulator.**

### 1. Create a Server Directory
> Replace `server_dir_name` with your desired directory name:

    mkdir -p server_dir_name

### 2. Download the Server Files
> Replace `server_dir_name` with the directory name you created earlier:

    wget -v -O ~/server_dir_name/server.jar https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar

### 3. Navigate to the Server Directory
> Move into the directory you created:

    cd ~/server_dir_name

### 4. Start the Server
> Run the server with the following command:

    java -Xmx1024M -Xms1024M -jar server.jar nogui

### 5. Accept the EULA
> Edit the EULA file to agree to Minecraft's End User License Agreement:

    nano eula.txt

- Change `eula=false` to `eula=true`
- Save and exit:
  - Press `Ctrl + X`, then type `Y`, and press `Enter`.


### 6. Configure Server Properties
> Modify the server's settings as needed:

    nano server.properties

> [!NOTE]
> This file allows you to configure options like the server's IP address and port. Be cautious and ensure you understand the changes you make.

# Step 7: Create a Startup Script (Optional)

### 1. Return to the User's Home Directory
> Navigate back to the home directory:

    cd

### 2. Create a Directory for Scripts
> Replace `name` with your desired directory name:

    mkdir name

### 3. Navigate to the New Directory
> Change to the directory you just created:

    cd name

### 4. Create a Startup Script
> Replace `factorio_server_manager.sh` with your desired script name, but ensure consistency in the following instructions:

    nano factorio_server_manager.sh

### 5. Make the Script Executable
> Allow the user to execute the script:

    chmod +x factorio_server_manager.sh

### 6. Copy and Edit the Script Variables
> Below is an example script template to customize:

    #!/bin/bash
    
    set -e  # Exit on any error

# Step 8: Create a Systemd Service (Optional)

### 1. Switch to Your Sudo User
> Replace `your_username` with the actual username used earlier:

    su your_username

### 2. Create the Systemd Service File
> Create the service configuration file:

    sudo nano /etc/systemd/system/factorio_server.service

### 3. Add the Service Configuration
> Below is a sample configuration:

    [Unit]
    Description=Custom Game Server
    After=network.target
    
    [Service]
    Type=simple
    User=yourusername                          # Define the user under which the service will run. Default is "user".
    ExecStart=/path/to/start_server.sh         # Path to the script that starts the server. 
    Restart=on-failure
    RestartSec=5
    StartLimitIntervalSec=60
    StartLimitBurst=3
    StandardOutput=/var/log/Minecraft_server.log    # Standard output and error logs. The log file location can be customized.
    StandardError=/var/log/Minecraft_server.log     # Standard output and error logs. The log file location can be customized.
    
    [Install]
    WantedBy=multi-user.target

> Example:
> `User=test`
> `ExecStart=/home/test/scripts/start_server.sh`

### 4. Enable and Start the Service
> Run the following commands to activate the service:

    sudo systemctl daemon-reload
    sudo systemctl enable factorio_server.service
    sudo systemctl start factorio_server.service

> [!Important]
>  *This systemd service, along with the accompanying script, ensures that your server automatically starts after a reboot.*

# Step 9: Hardening (Optional)

### 1. Edit the SSH Configuration
> Log in as the sudo user and edit the SSH daemon configuration file:

    sudo nano /etc/ssh/sshd_config

Update the following lines for improved security:

    LoginGraceTime 1m
    PermitRootLogin no
    MaxSessions 4

### 2. Reload and Restart the SSH Service
> Apply the changes by reloading systemd and restarting the SSH service:

    sudo systemctl daemon-reload
    sudo systemctl restart ssh.service

> **Example:**

![image](https://github.com/user-attachments/assets/f12f25af-807d-4981-9e53-ebe2ab3d2688)

These are some steps you can take to enhance the security of your SSH service.

# Restrict the Use of the `su` Command

### 1. Create a New Group
> Replace `group_name` with your desired group name:

    sudo groupadd group_name

> **Example:**
> `sudo groupadd restrictedsu`

**Edit who can use the *su* command**

> Edit the *su* config

    sudo nano /etc/pam.d/su

> Edit the following line to restrict su. Replace "*group_name*" with the one you made ealier.

    auth       required   pam_wheel.so group=group_name

> **Example:** 
> `auth       required   pam_wheel.so group=restrictedsu`

**Example:** 

![image](https://github.com/user-attachments/assets/3d3c941b-aadd-4bdb-b736-e2fb4c7b5c8b)


**Conclusion**

You have successfully set up your factorio server! For further customization, refer to the game’s official documentation.


- https://www.factorio.com/download
- https://wiki.factorio.com/Multiplayer
- https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
