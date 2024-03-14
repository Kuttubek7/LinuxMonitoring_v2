#!/bin/bash

if [[ $# -ne 0 ]]
then
    echo "Ошибка ввода! Запускаем скрипт без параметров"
else
    goaccess /home/kuttubek/Desktop/DO4_LinuxMonitoring_v2.0-1/src/04/*.log --log-format=COMBINED -o /home/kuttubek/Desktop/DO4_LinuxMonitoring_v2.0-1/src/06/output.html
    xdg-open output.html
fi