# Домашнее задание к занятию "14.4 Сервис-аккаунты"

### Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните задачу 1 как справочный материал.

#### Как создать сервис-аккаунт?
```
kubectl create serviceaccount netology
```
![ ](kub14_04_01.png)

#### Как просмотреть список сервис-акаунтов?
```
kubectl get serviceaccounts
kubectl get serviceaccount
```
![ ](kub14_04_02.png)

#### Как получить информацию в формате YAML и/или JSON?
```
kubectl get serviceaccount netology -o yaml
kubectl get serviceaccount default -o json
```
![ ](kub14_04_03.png)

#### Как выгрузить сервис-акаунты и сохранить его в файл?
```
kubectl get serviceaccounts -o json > serviceaccounts.json
kubectl get serviceaccount netology -o yaml > netology.yml
```
![ ](kub14_04_04.png)

#### Как удалить сервис-акаунт?
```
kubectl delete serviceaccount netology
```
![ ](kub14_04_05.png)

#### Как загрузить сервис-акаунт из файла?
```
kubectl apply -f netology.yml
```
![ ](kub14_04_06.png)



> Не сделано
> ### Задача 2 (*): Работа с сервис-акаунтами внутри модуля
> Выбрать любимый образ контейнера, подключить сервис-акаунты и проверить доступность API Kubernetes
```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```
> Просмотреть переменные среды
```
env | grep KUBE
```
> Получить значения переменных
```
K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
SADIR=/var/run/secrets/kubernetes.io/serviceaccount
TOKEN=$(cat $SADIR/token)
CACERT=$SADIR/ca.crt
NAMESPACE=$(cat $SADIR/namespace)
```
> Подключаемся к API
```
curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/
```
> В случае с minikube может быть другой адрес и порт, который можно взять здесь
```
cat ~/.kube/config
```
> или здесь
```
kubectl cluster-info
```