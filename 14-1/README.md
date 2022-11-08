# Домашнее задание к занятию "14.1 Создание и использование секретов"

### Задача 1: Работа с секретами через утилиту kubectl в установленном minikube

Выполните приведённые ниже команды в консоли, получите вывод команд. Сохраните задачу 1 как справочный материал.

#### Как создать секрет?
```
openssl genrsa -out cert.key 4096
openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
```
![ ](kub14_01_01.png)
![ ](kub14_01_02.png)

#### Как просмотреть список секретов?
```
kubectl get secrets
kubectl get secret
```
![ ](kub14_01_03.png)

#### Как просмотреть секрет?
```
kubectl get secret domain-cert
kubectl describe secret domain-cert
```
![ ](kub14_01_04.png)

#### Как получить информацию в формате YAML и/или JSON?
```
kubectl get secret domain-cert -o yaml
kubectl get secret domain-cert -o json
```
![ ](kub14_01_05.png)
![ ](kub14_01_06.png)
![ ](kub14_01_07.png)
![ ](kub14_01_08.png)

#### Как выгрузить секрет и сохранить его в файл?
```
kubectl get secrets -o json > secrets.json
kubectl get secret domain-cert -o yaml > domain-cert.yml
```
![ ](kub14_01_09.png)

#### Как удалить секрет?
```
kubectl delete secret domain-cert
```
![ ](kub14_01_10.png)

#### Как загрузить секрет из файла?
```
kubectl apply -f domain-cert.yml
```
![ ](kub14_01_11.png)


### Задача 2 (*): Работа с секретами внутри модуля

> Выберите любимый образ контейнера, подключите секреты и проверьте их доступность как в виде переменных окружения, так и в виде примонтированного тома.