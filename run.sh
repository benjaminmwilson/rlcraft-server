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
    
    echo -e "\e[1;33minstalling skyfactory4 mods\e[0m"
    mkdir -p /tmp/skyfactory4-mod
    curl -s https://media.forgecdn.net/files/3012/800/SkyFactory-4_Server_4.2.2.zip -o /tmp/skyfactory4.zip
    unzip -q /tmp/skyfactory4.zip -d /tmp/skyfactory4-mod
    
    find /tmp/skyfactory4-mod -maxdepth 1 -mindepth 1 -type d -exec cp -r {} . \;
    cp /tmp/skyfactory4-mod/options.txt .
    rm -rf /tmp/skyfactory4-mod /tmp/skyfactory4.zip
        
    popd
    
    echo -e "\e[1;33mremoving yum packages\e[0m"    
    yum -y remove unzip procps
    yum clean all
fi

cd /data
java -Xmx6144M -Xms6144M -jar forge.jar nogui
