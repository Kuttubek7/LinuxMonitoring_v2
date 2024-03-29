#!/bin/bash

date=$(date +"%d%b%Y")
record_count=$(( $RANDOM % 1000 + 100 ))
count_logfile=5

for (( num_logfile = 1; num_logfile <= $count_logfile; num_logfile++ ))
do
    for (( i = 0; i < $record_count; i++ ))
    do
        echo -n "$(shuf -n 1 -i 0-255).$(shuf -n 1 -i 0-255).$(shuf -n 1 -i 0-255).$(shuf -n 1 -i 0-255) " >> $num_logfile.log  #сгенерировать IP-адрес
        echo -n "- - [$(date -d $date +"%d/%b/%Y:")$(shuf -i 0-23 -n 1):$(shuf -i 0-59 -n 1):$(shuf -i 0-59 -n 1) +0000] " >> $num_logfile.log   #генерировать дату и время запроса 
        echo -n "\"$(shuf -n 1 HTTP_methods) $(shuf -n 1 PathToResource) HTTP/1.0\" " >> $num_logfile.log  #генерировать строку запроса от клиента
        echo -n "$(shuf -n 1 HTTP_code) " >> $num_logfile.log     #генерировать код состояния HTTP, возвращаемый клиенту
        echo -n "$(shuf -n 1 -i 3-3000) "  >> $num_logfile.log    #генерировать размер ответа, отправляемого клиенту
        echo -n "$(shuf -n 1 URL) "  >> $num_logfile.log          #создать URL-адрес реферера
        echo "\"$(shuf -n 1 agent)\" "  >> $num_logfile.log    #создать строку пользовательского агента
    done
    date=$(date -d "$date - 1 day" +"%d%b%Y")
done

# 200 ОК: запрос выполнен успешно, ответ содержит запрошенную информацию.
# 201 Создано: запрос был успешным, в результате был создан новый ресурс.
# 400 Неверный запрос: сервер не смог понять запрос из-за неверного синтаксиса или отсутствия параметра.
# 401 Несанкционировано: запрос требует аутентификации, но пользователь не предоставил действительные учетные данные.
# 403 Запрещено: сервер понял запрос, но отказывается его авторизовать. Обычно это означает, что у пользователя недостаточно прав для доступа к ресурсу.
# 404 Не найден: серверу не удалось найти запрошенный ресурс.
# 500 Внутренняя ошибка сервера: при обработке запроса на сервере произошла непредвиденная ошибка.
# 501 Не реализовано: сервер не поддерживает запрошенную функцию или функцию.
# 502 Bad Gateway: сервер, действующий как шлюз или прокси, получил неверный ответ от вышестоящего сервера.
# 503 Служба недоступна: сервер в настоящее время не может обработать запрос из-за временной перегрузки или технического обслуживания.
