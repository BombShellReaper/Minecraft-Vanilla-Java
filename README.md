# Setting Up a Dedicated Minecraft (Vanilla) Server

## **Overview**

- This is a step-by-step guide on how to set up and run a Factorio server.

## **Prerequisites**

This guide is not intended for complete beginners to Linux or server administration. It assumes the following:

> - Basic knowledge of Linux: You should be comfortable using the terminal (command line), understanding file system paths, and basic Linux commands like cd, ls, mkdir, and cp.
> - Basic networking understanding: Familiarity with concepts like IP addresses, ports, and SSH will help as you configure remote access to your server.
> - Experience with server setup: You should have some experience setting up and managing servers. This includes installing packages, configuring firewalls, and understanding security practices like disabling 
  root login.
> - Access to a Linux server: You should have a VPS or dedicated server with a fresh installation of a supported Linux distribution (Ubuntu or Debian recommended).
> - Root or Sudo privileges: You need to be able to execute administrative commands (with sudo or as root) on the server.
> - If you are not familiar with these concepts, you may want to spend some time with basic Linux tutorials before proceeding. This guide will walk you through the setup step-by-step, but we won’t be able to 
  cover fundamental Linux concepts in detail. You can find helpful resources online, such as the Linux Foundation’s tutorials, or consider following beginner guides for server setup.

> [!Caution]
> Directory structures may differ based on your specific setup. Always check paths and ensure you're working in the correct directories to avoid issues.

# Step 1: Update and Upgrade Your System

    sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y

# Step 2: Install Required Dependencies 
    
> Install Screen (Session Manager)

    sudo apt install screen -y

> **Install Java**

    sudo apt install openjdk-21-jdk-headless

> **Install nano (Text Editor)**

    sudo apt install nano

> **Install OpenSSH Sever**

    sudo apt install openssh-server -y
> [!NOTE]
> This enables secure remote access to your server.

> Install UFW (Uncomplicated Firewall)

    sudo apt install ufw -y

# Step 3: Configure UFW (Uncomplicated Firewall)

> Allow all incoming connections to port 25565 (This is the defualt server port):

    sudo ufw allow from any to any port 25565 comment "Minecraft Server Port"

> [!TIP]
> For improved security, restrict access to only trusted IP addresses.

**Allow SSH Connections Through UFW** (Optional)

    sudo ufw allow from any to any port 22 comment "SSH"

> [!TIP]
> For improved security, restrict access to only trusted IP addresses.

> Set the default rule to deny incoming traffic (Optional)

    sudo ufw default deny incoming

> **Enable UFW** (UFW will enable on reboot)

    sudo ufw enable

> Check the UFW status after enabling it:

    sudo ufw status
    
--------------------------------------------------------------------------------
# Step 4: Create a Non Sudo User

> Replace "*your_username*" with the desired username.

    sudo adduser your_username

> [!NOTE]
> This will prompt you through the setup

> **Reboot the system**

    sudo reboot

-------------------------------------------------------------------------------
# Step 5: Download the Factorio Dedicated Server Files & Set-Up
