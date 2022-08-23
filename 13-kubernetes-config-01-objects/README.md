# Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"

Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке 13-kubernetes-config.

### Задание 1: подготовить тестовый конфиг для запуска приложения

Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:

* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.


### Решение:

Собирала проект локально и запушила образы на dockerhub.
Запустила миникуб с лекции 12.1 и в нем применяла манифесты.

[deployment.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/stage/deployment.yaml)
```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: custom-app
  namespace: stage-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: custom-app
  template:
    metadata:
      labels:
        app: custom-app
    spec:
      containers:
      - image: anutkafluff/13-1kubernetes-config_backend:latest
        name: back
        ports:
        - containerPort: 9000
      - image: anutkafluff/13-1-kubernetes-config_frontend:latest
        name: front
        ports:
        - containerPort: 80

```

[statefulset.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/stage/statefulset.yaml)
```
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgresql
  namespace: stage-ns
spec:
  serviceName: postgres-service
  replicas: 1
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      containers:
        - name: postgresql
          image: postgres:13-alpine
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news
          volumeMounts:
            - name: postgres-volume
              mountPath: /var/lib/postgresql/data/
      volumes:
        - name: postgres-volume

```

[service_bd.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/stage/service_bd.yaml)
```
---
apiVersion: v1
kind: Service
metadata:
  name: postgres-service
  namespace: stage-ns
spec:
  type: ClusterIP
  selector:
    app: postgresql
  ports:
    - port: 5432
      targetPort: 5432
      protocol: TCP

```

[service_ingress.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/stage/service_ingress.yaml)

```
apiVersion: v1
kind: Service
metadata:
  name: ingress
  namespace: stage-ns
spec:
  ports:
    - name: web
      port: 80
      protocol: TCP
    - name: api
      port: 9000
      protocol: TCP
  selector:
    app: custom-app
  type: ClusterIP
```

Запуск:
```
kubectl create namespace stage-ns
kubectl apply -f stage
```

![ ](kub13_01_01.png)

Проверка работы, все описанные объекты запущены:
```
kubectl get deployments -n stage-ns
kubectl get pods -n stage-ns
kubectl get sts -n stage-ns
kubectl get svc -n stage-ns
```

![ ](kub13_01_02.png)

### Задание 2: подготовить конфиг для production окружения

Следующим шагом будет запуск приложения в production окружении. Требования сложнее:

* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

### Решение:

Подготовила манифесты для прода:

[back-deployment.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/prod/back-deployment.yaml)
```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: back-dep
  namespace: prod-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: back-app
  template:
    metadata:
      labels:
        app: back-app
    spec:
      containers:
      - image: anutkafluff/13-1kubernetes-config_backend:latest
        name: back-app
        ports:
        - containerPort: 9000
        env:
          - name: DATABASE_URL
            value: postgres://postgres:postgres@postgres-service:5432/news

```

[front-deployment.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/prod/front-deployment.yaml)
```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: front-dep
  namespace: prod-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: front-app
  template:
    metadata:
      labels:
        app: front-app
    spec:
      containers:
      - image: anutkafluff/13-1-kubernetes-config_frontend:latest
        name: front-app
        ports:
        - containerPort: 80
        env:
          - name: BASE_URL
            value: http://back:9000
```
[statefulset.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/prod/statefulset.yaml)
```
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
  namespace: prod-ns
spec:
  serviceName: postgres-service
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:13-alpine
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news
          volumeMounts:
            - name: postgres-volume
              mountPath: /var/lib/postgresql/data/
      volumes:
        - name: postgres-volume
```
[back-service.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/prod/back-service.yaml)
```
---
apiVersion: v1
kind: Service
metadata:
  name: back-service
  namespace: prod-ns
spec:
  type: ClusterIP
  selector:
    app: back-app
  ports:
    - port: 9000
      targetPort: 9000
      protocol: TCP

```
[front-service.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/prod/front-service.yaml)
```
---
apiVersion: v1
kind: Service
metadata:
  name: front-service
  namespace: prod-ns
spec:
  type: ClusterIP
  selector:
    app: front-app
  ports:
    - port: 8000
      targetPort: 80
      protocol: TCP

```
[postgresql-service.yaml](https://github.com/anna-maksimovna/devops-netology/blob/main/13-kubernetes-config-01-objects/prod/postgresql-service.yaml)
```
---
apiVersion: v1
kind: Service
metadata:
  name: postgres-service
  namespace: prod-ns
spec:
  type: ClusterIP
  selector:
    app: postgres
  ports:
    - port: 5432
      targetPort: 5432
      protocol: TCP
	  
```

Запуск:
```
kubectl create namespace prod-ns
kubectl apply -f prod
```

![ ](kub13_01_03.png)

Проверка работы, все описанные объекты запущены:
```
kubectl get deployments -n prod-ns
kubectl get pods -n prod-ns
kubectl get sts -n prod-ns
kubectl get svc -n prod-ns
```

![ ](kub13_01_04.png)
