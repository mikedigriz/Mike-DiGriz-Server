#!/bin/bash
port_server="25565" #игровой порт сервера
path_server="/home/digriz/server/" #путь к папке с сервером
count=15
while [ $count -gt 0 ]
do
status=$(lsof -i :$port_server | grep -c '25565')
if [ "$status" = "0" ];
then
if [ "$count" = "1" ];
then
date=$(date +%Y_%m_%d_%H_%M)
echo "$date: Процесс c портом $port_server не найден. Запуск..." >> /home/digriz/scriptlogall.txt
cd $path_server
wget https://papermc.io/ci/job/Paper-1.14/lastSuccessfulBuild/artifact/paperclip.jar -O paperclip.jar
screen -dmS "MainServer" java -Xms16G -Xmx16G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AggressiveOpts -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -jar paperclip.jar
fi
count=$[ $count - 1 ]
sleep 5
else
break
fi
done
