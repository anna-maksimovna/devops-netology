### Задача 1
Перед выполнением задания ознакомьтесь с документацией по администрированию MongoDB.

Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты происходит CRUD операция в MongoDB и её нужно прервать.

Вы как инженер поддержки решили произвести данную операцию:

напишите список операций, которые вы будете производить для остановки запроса пользователя
предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB
#### Ответ:
* **_Для нахождения операции можно использовать команду db.currentOp() и далее можно остановить операцию с помощью db.killOp()_**
* **_Решение: Нужно к зависающему запросу добавить .explain(“executionStats”)  и посмотреть в чем проблема, исходя из этого уже искать решение._**

### Задача 2
Перед выполнением задания познакомьтесь с документацией по Redis latency troobleshooting.

Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL. Причем отношение количества записанных key-value значений к количеству истёкших значений есть величина постоянная и увеличивается пропорционально количеству реплик сервиса.

При масштабировании сервиса до N реплик вы увидели, что:

сначала рост отношения записанных значений к истекшим
Redis блокирует операции записи
Как вы думаете, в чем может быть проблема?
#### Ответ:
**_Можно пройтись по чек-листу контроля окружения, проверить задержки, медленные операции и т.д. Но тут скорее всего проблема в нехватке оперативной памяти._**

### Задача 3
Перед выполнением задания познакомьтесь с документацией по Common Mysql errors.

Вы подняли базу данных MySQL для использования в гис-системе. При росте количества записей, в таблицах базы, пользователи начали жаловаться на ошибки вида:

InterfaceError: (InterfaceError) 2013: Lost connection to MySQL server during query u'SELECT..... '
Как вы думаете, почему это начало происходить и как локализовать проблему?

Какие пути решения данной проблемы вы можете предложить?
#### Ответ:
**_Вероятно, что из-за роста количества записей в БД запросы на выборку данных стали возвращать все больше данных, из-за этого не всегда информация успевает передаваться. Для решения можно увеличить значение net_read_timeout. Еще как вариант, так как это гис-система, то в БД могут храниться BLOB-объекты, тогда можно увеличить max_allowed_packet._**

### Задача 4
Перед выполнением задания ознакомтесь со статьей Common PostgreSQL errors из блога Percona.

Вы решили перевести гис-систему из задачи 3 на PostgreSQL, так как прочитали в документации, что эта СУБД работает с большим объемом данных лучше, чем MySQL.

После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:

postmaster invoked oom-killer

Как вы думаете, что происходит?

Как бы вы решили данную проблему?
#### Ответ:
**_Проблема в нехватке памяти, из-за этого процесс с PostgreSql был уничтожен._**

* **_Чтобы обойти эту проблему, нужно  запускать Postgres на машине, где никакие другие процессы не займут всю память. Если физической памяти недостаточно, можно увеличить объём пространства подкачки._**
* **_Также может помочь уменьшение конфигурационных параметров как  shared_buffers, work_mem или  max_connections._**
* **_Для уменьшения вероятности вызова OOM killer можно включить режим строгого выделения памяти, воспользовавшись sysctl:_**
```
sysctl -w vm.overcommit_memory=2
```
* **_Другой подход:  исключение процесса postmaster из числа возможных жертв при нехватке памяти. Для этого нужно задать свойство, которое уменьшит “стоимость” процесса , когда за работу возьмется OOM killer . Это можно сделать, выполнив:_**
```
echo -1000 > /proc/self/oom_score_adj
```