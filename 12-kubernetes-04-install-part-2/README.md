# �������� ������� � ������� "12.4 ������������� �������� �� ����������� ��������, ������ 2"

����� ������� ����� ���������� �������. ������ ������ ������� ���� ��������� ���������: ��� ����� � ���������. ������ ��� ������ � �� �������, ������� ����� ���������������� ���������� ����� ���������.

### ������� 1: ����������� ��������� kubespray

����� �������� �������� ������� �������� ������� ��������. ����� ����������� ��������� � ��������� ��� ������. ���������� � ���������:

* ���������� ������ �������� �� 5 ���: 1 ������ � 4 ������� ����;
* � �������� CRI � containerd;
* ������ etcd ����������� �� �������.

## �������:

� ������ �������, ��� ����� 1 ������-���� � 2 ������� ���� ���������� - ������ ���.
��� ����� ��������� 3 ����������� ������ �� Yandex Cloud.

��������� kubespray ������:
```
git clone https://github.com/kubernetes-sigs/kubespray
```

�������� ����� inventory/sample ���  inventory/mycluster

� inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml ��� �� ��������� �����������:
```
container_manager: containerd
```
���������:
```
cd kubespray
sudo pip3 install -r requirements.txt
```

```
# ���������� Ansible inventory � ������� ������� 
declare -a IPS=(51.250.29.0 84.252.143.68 51.250.110.181)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

��������������� hosts.yaml �.�. ���������� �����-�� ��������, ������� ���� �� ������� � ������������ ���, ����� ���� ���� ������-���� � 2 �������. 

��������� ������������� ��������:
```
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```

� ����� ��������� ������ �������, ���� ���� ������������ ��-�� ���� ��� ������������� hosts.yaml � ���� ������� � ip ��������.

![ ](kub12_04_01.png)

����� ��������� ����� �� ������-���� ��� ��������:
```
kubectl get nodes
```

������� ������ ������:
```
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```

![ ](kub12_04_02.png)

����� �������:
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

��� ��� ��������� ������� � ���� � ��������� Ready:
```
kubectl get nodes
```

![ ](kub12_04_03.png)
