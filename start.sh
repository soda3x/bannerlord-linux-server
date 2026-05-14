#!/bin/bash

SERVER_DIR="/home/bannerlord/server"
APP_ID="1863440"

mkdir -p "$SERVER_DIR/Modules/Native/MultiplayerForcedAvatars"

echo "=== Downloading/Updating Bannerlord Server via SteamCMD ==="
/home/bannerlord/steamcmd/steamcmd.sh \
    +force_install_dir "$SERVER_DIR" \
    +login anonymous \
    +app_update $APP_ID validate \
    +quit

cp -R /usr/share/dotnet/shared/Microsoft.AspNetCore.App/6.0.36/. "$SERVER_DIR/bin/Linux64_Shipping_Server/"

echo "=== Starting Mount & Blade II: Bannerlord Dedicated Server ==="
cd "$SERVER_DIR/bin/Linux64_Shipping_Server"

cp /home/bannerlord/config.txt "$SERVER_DIR/Modules/Native/config.txt"

dotnet TaleWorlds.Starter.DotNetCore.Linux.dll \
_MODULES_*Native*Multiplayer*_MODULES_ \
/dedicatedcustomserverconfigfile config.txt \
/dedicatedcustomserverauthtoken "$SERVER_AUTH_TOKEN" \
/dedicatedcustomserver 7210 USER 0 \
/playerhosteddedicatedserver