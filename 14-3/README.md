# Домашнее задание к занятию "14.3 Карты конфигураций"

### Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните задачу 1 как справочный материал.

#### Как создать карту конфигураций?
```
kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru
```
![ ](kub14_03_01.png)

#### Как просмотреть список карт конфигураций?
```
kubectl get configmaps
kubectl get configmap
```
![ ](kub14_03_02.png)

#### Как просмотреть карту конфигурации?
```
kubectl get configmap nginx-config
kubectl describe configmap domain
```
![ ](kub14_03_03.png)

#### Как получить информацию в формате YAML и/или JSON?
```
kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
```
![ ](kub14_03_04.png)
![ ](kub14_03_05.png)

#### Как выгрузить карту конфигурации и сохранить его в файл?
```
kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
```
![ ](kub14_03_06.png)

#### Как удалить карту конфигурации?
```
kubectl delete configmap nginx-config
```
![ ](kub14_03_07.png)

#### Как загрузить карту конфигурации из файла?
```
kubectl apply -f nginx-config.yml
```
![ ](kub14_03_08.png)


> Не сделано
> ### Задача 2 (*): Работа с картами конфигураций внутри модуля
> Выбрать любимый образ контейнера, подключить карты конфигураций и проверить их доступность как в виде переменных окружения, так и в виде примонтированного тома