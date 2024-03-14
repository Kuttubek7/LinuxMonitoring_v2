#!/bin/bash

date=$(date +"%d%m%y")
start_date=0
start_time=0
end_date=0
end_time=0
check_date='^2023-([0][1-9]|[1][0-2])-([0][1-9]|[1-2][0-9]|[3][0-1])$'
check_time='^([0][0-9]|[1][0-9]|[2][0-4]):([0-5][0-9]|[6][0])$'


if [[ $# -ne 1 ]]
then
    echo "Ошибка ввода. Запустите скрипт с одним параметром."
    exit 1

elif [[ $1 -gt 3 || $1 -lt 1 ]]
then
    echo "Ошибка ввода. Параметр может быть только числом: 1, 2 или 3."
    exit 2
fi

if [[ $1 -eq 1 ]] #удаление по лог файлу
then
    count_rm_path=$(awk 'END{print NR}' ../01/infod.log)
    i=1
    while [[ $i -le $count_rm_path ]]
    do
        path_name=$(awk 'NR == '$i' {print $1}' ../01/infod.log)
        sudo rm -vr "$path_name"
        ((i++))
    done

elif [[ $1 -eq 2 ]] #удаление по точному промежутку времени
then
    while true
    do
        read -p "Пожалуйста, введите начало временного интервала - дату и время (с точностью до минуты) удаления файлов. Вам следует использовать этот формат — ГГГГ-ММ-ДД ЧЧ:ММ. " start_date start_time
        if [[ $start_date =~ $check_date && $start_time =~ $check_time ]]
        then
            break
        else
            echo "Неправильный ввод!"
        fi
    done
    
    while true
    do
        read -p "Пожалуйста, введите окончание временного интервала - дату и время (с точностью до минуты) удаления файлов. Вам следует использовать этот формат — ГГГГ-ММ-ДД ЧЧ:ММ. " end_date end_time
        if [[ $end_date =~ $check_date && $end_time =~ $check_time ]]
        then
            break
        else
            echo "Неправильный ввод!"
        fi
    done

    sudo find / -type d -name "*_$date" -newermt "$start_date $start_time" ! -newermt "$end_date $end_time" -exec rm -rv '{}' \;
    
elif [[ $1 -eq 3 ]] #удаление по маске имени
then
    sudo find / -type d -name "*_$date" -exec rm -rv '{}' \;
fi

# sudo ls / -l - отобразить полную информацию, где будет время и дата.