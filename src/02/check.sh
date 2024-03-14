#!/bin/bash

dir_check='^[A-Za-z]{1,7}$'
file_check='^[A-Za-z]{1,7}\.{1,1}[A-Za-z]{1,3}$'
size_of_file_check='^[0-9]+mb|Mb|MB|mB$'
num_size=$(echo $3 | sed 's/'[mM][bB]'//')


check() {
    if [ $count_param -ne 3 ]
    then
        echo "Неправильный ввод! Запустите скрипт, используя 3 параметра."
        exit 1

    elif ! [[ $1 =~ $dir_check ]]
    then
        echo "Неправильный ввод первого параметра! Имя папки должно содержать только буквы A-Z, a-z, не повторяться, и вы можете использовать не более 7 букв."
        exit 2

    elif ! [[ $2 =~ $file_check ]]
    then
        echo "Неправильный ввод второго параметра!"
        echo "Имя файла должно содержать только буквы A-Z, A-Z, и вы можете использовать не более 7 букв для имени и не более 3 букв для расширения. Буквы в имени и расширении не могут повторяться. Пример: sdf.ex"
        exit 3
    
    elif [ $num_size -gt 100 ]
    then
        echo "Ошибка ввода третьего параметра! Размер не может превышать 100mb."
        exit 4

    elif ! [[ $3 =~ $size_of_file_check ]]
    then
        echo "Ошибка ввода третьего параметра! Пожалуйста, напишите размер файлов. Пример: 99mb."
        exit 5
    fi
}
