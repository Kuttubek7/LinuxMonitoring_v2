#!/bin/bash

while true
do
# Формирую http страницу через prometheus
    # > /data/metrics/index.html
    > /usr/share/nginx/html/metrics.html
    IDLE_TIME=$(sudo cat /proc/stat | grep cpu | awk 'NR==1{print $5}')
    TOTAL_TIME=$(sudo cat /proc/stat | grep cpu | awk 'NR==1 {print $2+$3+$4+$5+$6+$7+$8+$9+$10}')
    #CPU_USAGE=$(echo "scale=2; 100 * ($TOTAL_TIME - $IDLE_TIME) / $TOTAL_TIME" | bc)
    CPU_USAGE=$(sudo echo "$TOTAL_TIME $IDLE_TIME" | awk '{printf "%.3f", 100 * ($1 - $2) / $1}')
    sudo echo "cpu_usage_total $CPU_USAGE" >> /usr/share/nginx/html/metrics.html

    USED_RAM="$(sudo free | awk 'NR==2{print $3}')"
    sudo echo "ram_usage_total $USED_RAM" >> /usr/share/nginx/html/metrics.html

    DISK_USED="$(sudo df / | awk 'NR==2{print $3}')"
    DISK_FREE="$(sudo df / | awk 'NR==2{print $4}')"
    sudo echo "disk_used_total $DISK_USED" >> /usr/share/nginx/html/metrics.html
    sudo echo "disk_available_total $DISK_FREE" >> /usr/share/nginx/html/metrics.html
    sleep 3
done