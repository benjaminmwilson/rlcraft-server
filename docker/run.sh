#!/usr/bin/env bash

if [ ! -f "/data/eula.txt" ]; then
    echo -e "\e[1;33mfirst time setup\e[0m"

    echo -e "\e[1;33mcopying default settings\e[0m"
    cp -r default/. /data

    echo -e "\e[1;33minstalling yum packages\e[0m"
    yum -y install unzip procps
    
    pushd /data
    
    echo -e "\e[1;33mrunning forge\e[0m"    
    curl -s https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2855/forge-1.12.2-14.23.5.2855-installer.jar -o forge-installer.jar
    java -jar forge-installer.jar --installServer && rm forge-installer.jar
    find . -maxdepth 1 -regextype egrep -regex "\.\/forge-[1-9].*\.jar" -exec mv {} forge.jar \;
    
    echo -e "\e[1;33mrunning server for first time and creating world\e[0m"
    java -Xmx6144M -Xms6144M -jar forge.jar nogui &
    sleep 120s
    echo -e "\e[1;33mstopping server\e[0m"
    pkill java
    sleep 20s
    
    echo -e "\e[1;33minstalling rlcraft mods\e[0m"
    mkdir -p /tmp/rlcraft-mod
    curl -s https://media.forgecdn.net/files/2935/323/RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip -o /tmp/rlcraft.zip
    unzip -q /tmp/rlcraft.zip -d /tmp/rlcraft-mod
    
    find /tmp/rlcraft-mod -maxdepth 1 -mindepth 1 -type d -exec cp -r {} . \;
    cp /tmp/rlcraft-mod/options.txt .
    rm -rf /tmp/rlcraft-mod /tmp/rlcraft.zip
        
    popd
    
    echo -e "\e[1;33mremoving yum packages\e[0m"    
    yum -y remove unzip procps
    yum clean all
fi

cd /data
java -Xmx6144M -Xms6144M -jar forge.jar nogui
