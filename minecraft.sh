#!/usr/bin/env bash

# This is the script we used for Amzazon Linux 2 instance, you will need to replace $username with your user or use a different path on your machine.
echo "###### --> getting minecraft mods"

# Minecraft goes here
mkdir /home/${username}/minecraft
cd /home/${username}/minecraft
mkdir mods
mkdir data
cd /home/${username}/minecraft/mods
wget https://media.forgecdn.net/files/3934/702/Dynmap-3.4-fabric-1.19.1.jar
wget https://mediafilez.forgecdn.net/files/4033/215/fabric-carpet-1.19.2-1.4.84%2Bv221018.jar
wget https://cdn.modrinth.com/data/P7dR8mSH/versions/25Hm7c3j/fabric-api-0.69.0%2B1.19.2.jar

echo "###### --> Adding Minecraft config"

cd /home/${username}/minecraft/
echo "#Minecraft server properties
#Minecraft server properties
#Sun Dec 18 13:21:33 GMT 2022
allow-flight=true
allow-nether=false
broadcast-console-to-ops=true
broadcast-rcon-to-ops=true
difficulty=peaceful
enable-command-block=false
enable-jmx-monitoring=false
enable-query=false
enable-rcon=true
enable-status=true
enforce-secure-profile=true
enforce-whitelist=false
entity-broadcast-range-percentage=100
force-gamemode=false
function-permission-level=2
gamemode=creative
generate-structures=false
generator-settings={}
hardcore=false
hide-online-players=false
level-name=world
level-seed=
level-type=minecraft\:flat
max-chained-neighbor-updates=1000000
max-players=20
max-tick-time=60000
max-world-size=29999984
motd=Welcome to DevOps Playground!
network-compression-threshold=256
online-mode=true
op-permission-level=4
player-idle-timeout=0
prevent-proxy-connections=false
previews-chat=false
pvp=false
query.port=25565
rate-limit=0
rcon.password=PandaTime
rcon.port=25575
require-resource-pack=false
resource-pack=
resource-pack-prompt=
resource-pack-sha1=
server-ip=
server-port=25565
simulation-distance=10
spawn-animals=false
spawn-monsters=false
spawn-npcs=false
spawn-protection=16
sync-chunk-writes=true
text-filtering-config=
use-native-transport=true
view-distance=10
white-list=false
allow-cheats=true
max-map-size=1024
" > server.properties
cp /home/${username}/minecraft/server.properties /home/${username}/minecraft/data/server.properties

# Change permissions to the folders
sudo chown -R ${username}:${username} /home/${username}/workdir
sudo chown -R ${username}:${username} /home/${username}/minecraft

echo "###### --> Running Minecraft container"
# Run Minecraft server
docker run -d \
    -v "$PWD/data:/data" \
    -v "$PWD/mods:/mods" \
    -v "$PWD/server.properties:/server.properties" \
    -e TYPE=FABRIC \
    -e VERSION=1.19.2 \
    -e OVERRIDE_SERVER_PROPERTIES="false" \
    -e CREATE_CONSOLE_IN_PIPE="true" \
    -p 25565:25565 \
    -p 8123:8123 \
    -p 25575:25575 -e EULA=TRUE -e MEMORY=16G --name mc itzg/minecraft-server


docker exec mc mc-send-to-console /gamerule doWeatherCycle false
docker exec mc mc-send-to-console /gamerule doDaylightCycle false
docker exec mc mc-send-to-console /time set 12

echo "###### --> Adding helper aliases"
cat <<EOF >>/home/${username}/.bashrc
alias render-flat="docker exec mc mc-send-to-console /dynmap fullrender world:flat"
alias render-3d="docker exec mc mc-send-to-console /dynmap fullrender world:surface"
alias render-stop="docker exec mc mc-send-to-console /dynmap cancelrender world"
alias mc-logs="docker logs -f mc"
EOF
