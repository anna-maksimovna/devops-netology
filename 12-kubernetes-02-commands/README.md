# �������� ������� � ������� "12.2 ������� ��� ������ � Kubernetes"

������� � ��� ������� �������, � ������� ������ ����� �������� ���� �������. ����������������� devops ����� �������� ������ ���� �������, ������������ �����-���� ��������. ����� ���������� � ��������� ��� ��������� ������ ������ ���������� �������������. ������ ����� ��������� ��������� ������� ��� ��������� �����.

### ������� 1: ������ ���� �� ������ � �����������

��� ������ ������� ����������� � ������ �������� ���������� �� �������. ����� ������ ������� ������ ���������� ����������� ������� � ��������. ��������� ��������� ���������� �� ������ ������ �� hello world ��� ����� deployment. ����� ����� ��������� 2 ����� ���������� (replicas=2).

����������:

* ������ �� hello world ������� � �������� deployment
* ���������� ������ � deployment ����������� � 2
* ������� deployment ����� ��������� �������� kubectl get deployment
* ������� ����� ����� ��������� �������� kubectl get pods

## �������:
```
kubectl create namespace test-ns
kubectl create deployment hello-node-dep -n test-ns --image=k8s.gcr.io/echoserver:1.4 --replicas=2
```

���������:
```
kubectl get deployments -n test-ns
kubectl get pods -n test-ns
```

 ![ ](kub12_02_01.png)


### ������� 2: �������� ����� ��� ����������

������������� ������ ����� �������� �������� ����� �� ������ ����������� ���������� �, ��� ������, �� ������� � ��� ������. ��������� ������� ������������ � ������ ��� ������ �� ������ ������������ � ����� ����� � app-namespace.

����������:

* ������ ����� ����� ������� ��� ������������
* ������������ �������� � ��������� ������ (~/.kube/config, ���� users)
* ������������ ����� ������������� ���� ����� � �� ������������ (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)

## �������:

������ �� ����������� ������ 3 ����� ��� ��������� ����� � ��� ����:

������� ��������� �������:
```
kubectl apply -f serviceaccount.yaml -n test-ns
kubectl apply -f role.yaml -n test-ns
kubectl apply -f rolebinding.yaml -n test-ns
```

������:
```
cat ~/.kube/config
```

![ ](kub12_02_02.png)

��������, ��� ����� ����:
```
kubectl get pods -n test-ns --as=system:serviceaccount:test-ns:anna
kubectl describe pods hello-node-dep-7d975f54ff-dsp92 -n test-ns --as=system:serviceaccount:test-ns:anna
kubectl logs hello-node-dep-7d975f54ff-dsp92 -n test-ns --as=system:serviceaccount:test-ns:anna
```

![ ](kub12_02_03.png)

![ ](kub12_02_04.png)

![ ](kub12_02_05.png)

![ ](kub12_02_06.png)

��������, ��� ��� ���� �� ������ ��������:
```
kubectl get pods --as=system:serviceaccount:test-ns:anna
kubectl get deployments -n test-ns --as=system:serviceaccount:test-ns:anna
```

![ ](kub12_02_07.png)

![ ](kub12_02_08.png)



### ������� 3: ��������� ���������� ������

��������� � �����������, �� �������� ������ �� ���������� ���������� ������ ���������� ��� ��������. ���������� �������� ���������� deployment, �������� ���������� ������ �� 5. ���������� ������ ���������� ����� ����� ���������� ������.

����������:

* � deployment �� ������� 1 �������� ���������� ������ �� 5
* ��������� ��� ��� ���� ������� � ������ running (kubectl get pods)


## �������:

��������� �������:

```
kubectl scale --replicas=5 deployment hello-node-dep -n test-ns
```

���������:

```
kubectl get deployments -n test-ns
kubectl get pods -n test-ns
```

![ ](kub12_02_09.png)