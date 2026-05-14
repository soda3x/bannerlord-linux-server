#!/bin/bash

SERVER_DIR="/home/bannerlord/server"
APP_ID="1863440"

echo "=== Downloading/Updating Bannerlord Server via SteamCMD ==="
# Force Windows platform since there is no native Linux server
/usr/games/steamcmd +@sSteamCmdForcePlatformType windows \
    +force_install_dir "$SERVER_DIR" \
    +login anonymous \
    +app_update $APP_ID validate \
    +quit

export DISPLAY=:99
Xvfb :99 -screen 0 1024x768x16 &

echo "=== Starting Mount & Blade II: Bannerlord Dedicated Server ==="
cd "$SERVER_DIR/bin/Win64_Shipping_Server"

# Run the server via Wine. 
# You can append extra launch arguments or config files here.
wine DedicatedCustomServer.Starter.exe \
    _MODULES_*Native*Multiplayer* \
    /dedicatedcustomserverconfigfile /home/bannerlord/config.txt \
    /dedicatedcustomserverauthtoken "${SERVER_AUTH_TOKEN}"