# Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"

### Задача 1: Работа с модулем Vault

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

```
kubectl apply -f 14.2/vault-pod.yml
```
![ ](kub14_02_01.png)

Получить значение внутреннего IP пода
```
kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
```
![ ](kub14_02_02.png)

Примечание: jq - утилита для работы с JSON в командной строке

Запустить второй модуль для использования в качестве клиента
```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```

Установить дополнительные пакеты
```
dnf -y install pip
pip install hvac
```
![ ](kub14_02_03.png)
![ ](kub14_02_04.png)

Запустить интепретатор Python и выполнить следующий код, предварительно поменяв IP и токен
```
import hvac
client = hvac.Client(
    url='http://10.10.133.71:8200',
    token='aiphohTaa0eeHei'
)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

# Читаем секрет
client.secrets.kv.v2.read_secret_version(
    path='hvac',
)
```
![ ](kub14_02_05.png)
![ ](kub14_02_06.png)
![ ](kub14_02_07.png)
![ ](kub14_02_08.png)


### Задача 2 (*): Работа с секретами внутри модуля

> На основе образа fedora создать модуль;
> Создать секрет, в котором будет указан токен;
> Подключить секрет к модулю;
> Запустить модуль и проверить доступность сервиса Vault.