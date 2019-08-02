#!/usr/bin/env bash

while true; do
    java -Xmx20000m -Xms20000m -XX:+AlwaysPreTouch -XX:+DisableExplicitGC \
        -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 \
        -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 \
        -XX:InitiatingHeapOccupancyPercent=10 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AggressiveOpts \
        -XX:+ParallelRefProcEnabled \
        -jar spigot-1.14.jar

    echo "Рестарт через 5 сек, жми Ctr-C чтобы отменить"
    sleep 5
done
