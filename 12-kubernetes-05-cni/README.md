# �������� ������� � ������� "12.5 ������� ������� CNI"

����� ������ � Flannel ��������� ������������� ���������� ������������ ��� ����������. ��� ����� ����� ����� �������� Calico.

### ������� 1: ���������� � ������� CNI ������ Calico

��� �������� ������ ������� ������� ����� ��������� �������� �� Flannel ������ � ��������, Calico. ����������:

* ��������� ������������ ����� ansible/kubespray;
* ����� ���������� ������� ��������� �������� ������� � hello-world �����. ���������� kubernetes.io, Calico

## �������:

���������� ������� � ������� kubespray � Calico:

![ ](../12-kubernetes-04-install-part-2/kub12_04_01.png)

������� ����������
```
kubectl create namespace test-ns
kubectl create deployment hello-node-dep -n test-ns --image=k8s.gcr.io/echoserver:1.4 --replicas=2
```

��������� ��������� �����������:
```
kubectl get deployments -n test-ns
```

![ ](kub12_05_01.png)

����������� ���� � �������� ���������� networkpolicy.yaml

��������� NetworkPolicy:
```
kubectl apply -f networkpolicy.yaml
```

![ ](kub12_05_02.png)

### ������� 2: �������, ��� �������� �� ���������

����� ������� ������ � ��������� �������� calicoctl get . ��� �������� ����� �������� ������ ���, ipPool � profile. ����������:

* ���������� ������� calicoctl;
* �������� 3 ������������� ���� � �������.

## �������:

��������� calicoctl:
```
cd /usr/local/bin/
curl -L https://github.com/projectcalico/calico/releases/download/v3.23.3/calicoctl-linux-amd64 -o calicoctl
sudo chmod +x ./calicoctl
```

![ ](kub12_05_03.png)

��������, �������� ������ ���, ipPool � profile:
```
calicoctl get ipPool
calicoctl get nodes
calicoctl get profile
```

![ ](kub12_05_04.png)

![ ](kub12_05_05.png)

![ ](kub12_05_06.png)