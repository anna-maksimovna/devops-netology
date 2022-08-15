# �������� ������� � ������� "12.1 ���������� Kubernetes"

�� DevOps ������� � ������� �������� � ������� ������ ��������. ���� ������ � ������������� ��� �������� � ������������� ��������.

### ������ 1: ���������� Minikube

��� ������������� � ��������� ����� ������� ��� ����� ����������� �������� ����� ��� ������ � Kubernetes. ����������� ������� � ���������� �� ������� ������ Minikube.

��� ��������� �� AWS:
* ������� EC2 ����������� ������ (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type) � ����� t3.small. ��� ������ ����������� ��������� Security Group ��� ������� �� ssh. �� �������� ������� keypair, �� ����������� ��� �����������.
* ������������ � ������� �� ssh (ssh ubuntu@<ipv4_public_ip> -i .pem)
* ���������� ������� � ����� ���������� ���������:
> curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
> chmod +x ./kubectl
> sudo mv ./kubectl /usr/local/bin/kubectl
> sudo apt-get update && sudo apt-get install docker.io conntrack -y
> curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
* ��������� ������ ����� �������� minikube version
* ������������� �� root � ��������� �������: minikube start --vm-driver=none
* ����� ������� ����� ��������� ������: minikube status
* ���������� ��������� ���������� ����� ������� ��������: kubectl get pods --namespace=kube-system

��� ������ �������� ����� ������� ������� � ������� ������:

> minikube delete
> minikube start --vm-driver=none

��������, ��� ���������� ������� ����������� ��������� �������: sudo sysctl fs.protected_regular=0

���������� �� ��������� Minikube - ������

�����: t3.small �� ������ �� free tier, ������� �� �������� �������� � �������� ���������.

## �������:

������������� ��� �� ����������� ������ � Yandex Cloud.

��������� �������:

> curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
> chmod +x ./kubectl
> sudo mv ./kubectl /usr/local/bin/kubectl
> sudo apt-get update && sudo apt-get install docker.io conntrack -y
> curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

> minikube version
> minikube start --vm-driver=none

��������� �� ����������, ���� ������. ���������� ��������� �������:

> // ��������� golang ��� ��������� cri-dockerd
> // ������ �� ������ https://tecadmin.net/how-to-install-go-on-ubuntu-20-04/
> sudo apt-get update  
> sudo apt-get -y upgrade 
> sudo wget https://go.dev/dl/go1.17.13.linux-amd64.tar.gz
> sudo tar -C /usr/local -xzf go1.17.13.linux-amd64.tar.gz
> export GOROOT=/usr/local/go
> export GOPATH=$HOME/Projects/Proj1
> export PATH=$GOPATH/bin:$GOROOT/bin:$PATH


> //��������� cri-dockerd
> /*
> ��� ����������� ������:
> Exiting due to NOT_FOUND_CRI_DOCKERD: 
> ??  Suggestion: 
>     The none driver with Kubernetes v1.24+ and the docker container-runtime requires cri-dockerd.    
>     Please install cri-dockerd using these instructions:    
>     https://github.com/Mirantis/cri-dockerd#build-and-install
> */
> 
> git clone https://github.com/Mirantis/cri-dockerd.git
> cd cri-dockerd
> mkdir bin
> go build -o bin/cri-dockerd
> mkdir -p /usr/local/bin
> 
> sudo install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
> sudo cp -a packaging/systemd/* /etc/systemd/system
> sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
> sudo systemctl daemon-reload
> sudo systemctl enable cri-docker.service
> sudo systemctl enable --now cri-docker.socket

> //��������� crictl
> //��� ����������� ������:
> // sudo: crictl: command not found
> 
> VERSION="v1.24.2"
> wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
> sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
> rm -f crictl-$VERSION-linux-amd64.tar.gz

> //��� ��������� ���� �� �����
> //��� ����������� ������
> /*Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/version": dial unix /var/run/docker.sock: connect: permission denied
> */
> 
> sudo chmod 666 /var/run/docker.sock


����� ���������� ���������� �������:
> minikube start --vm-driver=none
> minikube status
> kubectl get pods --namespace=kube-system

 ![ ](kub12_01_01.png)
 
 ![ ](kub12_01_02.png)
 
 ![ ](kub12_01_03.png)


### ������ 2: ������ Hello World

����� ��������� Minikube ��������� ��� ���������. ��� ����� �������� ����������� ���������� hello world. � ��� ������� � ���� ����������� ingress.

* ���������� ����� Minikube �������� ���������� �� ���������
* ���������� ������ ingress � dashboard

## �������:

� ������� ���� �� ���������� ����������:

> kubectl get nodes

���������, ��� node ��� � ��������� NotReady ��-�� ����, ��� �� ���������� ������ ������� cni

�������� ������� flannel, �� � ��� **��** ����������:
> kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

**��������� � calico:**

> curl https://docs.projectcalico.org/manifests/calico.yaml -O 
> kubectl apply -f calico.yaml

����� ��� �� ���������, ��������� �������:
> kubectl get nodes
> kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
> kubectl get deployments
> kubectl get pods

��� ����������������� ������� �������, ��� ��� � ������� Ready:

![ ](kub12_01_04.png)

> kubectl expose deployment hello-node --type=LoadBalancer --port=8080
> minikube service hello-node

������� � �������� http://51.250.104.88:32521/ - ������������ ���������.

![ ](kub12_01_05.png)

![ ](kub12_01_06.png)

���������� ������:

> minikube addons enable ingress
> minikube addons enable dashboard
> minikube addons list

![ ](kub12_01_07.png)

![ ](kub12_01_08.png)

### ������ 3: ���������� kubectl

����������� ������� ������ ��� ���������� ������������� ���������. ���������� ���������� ���������� kubectl.

* ������������ � minikube
* ��������� ������ ���������� �� ������� 2, �������� port-forward �� ��������


## �������:

����� ���� �� ����������. ��������� �������:

> sudo apt-get -y install socat

����� ��������� port-forward:

> kubectl port-forward hello-node-6d5f754cc9-wj2xp 8081:8080 �address=0.0.0.0

���������:

![ ](kub12_01_09.png)

![ ](kub12_01_10.png)