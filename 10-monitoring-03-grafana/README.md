# �������� ������� � ������� "10.03. Grafana"
### ������� 1
**��������� ���������� help ������ ������� ��������� ������� - ��������� ������ prometheus-grafana.**

**������� � ���-��������� �������, ��������� ��������������� ������, ��������� � ��������� docker-compose.**

**���������� �������� ���� prometheus ��� �������� ������.**

**������� ��������� ������� - �������� ���-���������� grafana �� ������� ������������ Datasource.**

![ ](mnt10_03_1.png)

### ������� 2
   
**������� �������������� �������:**

**promql-for-humans**
**understanding prometheus cpu metrics**
**�������� Dashboard � � ��� �������� ��������� Panels:**

* **���������� CPU ��� nodeexporter (� ���������, 100-idle)**

(avg by (instance)(irate(node_cpu_seconds_total{instance="nodeexporter:9100", mode="idle"}[1m]))*100)

* **CPULA 1/5/15**

node_load1{instance="nodeexporter:9100",job="nodeexporter"}

node_load5{instance="nodeexporter:9100",job="nodeexporter"}

node_load15{instance="nodeexporter:9100",job="nodeexporter"}

* **���������� ��������� ����������� ������**

node_memory_MemAvailable_bytes{instance="nodeexporter:9100",job="nodeexporter"}

* **���������� ����� �� �������� �������**

node_filesystem_avail_bytes{instance="nodeexporter:9100",fstype="ext4"}

node_filesystem_size_bytes{instance="nodeexporter:9100",fstype="ext4"}

**��� ������� ������� �� ��������� promql ������� ��� ������ ���� ������, � ����� �������� ������������ Dashboard.**

![ ](mnt10_03_2.png)

### ������� 3
 
**�������� ��� ������ Dashboard ���������� ������� alert (����� ���������� � ������ ������ � ����� "����������").��� ������� �� - ��������� �������� ����� �������� Dashboard.**

� ���� �������� ������ � ����� ������ ���� �������� ������� alert, ������� �������� ������ ����.
![ ](mnt10_03_3.png)
 
### ������� 4
   
**��������� ��� Dashboard.**

**��� ����� ��������� � ��������� Dashboard, �������� � ������� ���� "JSON MODEL".**

**����� ���������� ������������ json-���������� � ��������� ���� � ��������� ���.**

**� ������� ������� - ��������� ������� ����� �����.**

 [Dashboard](https://github.com/anna-maksimovna/devops-netology/blob/main/10-monitoring-03-grafana/dashboard.json)
