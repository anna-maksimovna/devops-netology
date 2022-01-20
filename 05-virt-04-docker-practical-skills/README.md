### ������ 1
� ������ ������� �� ��������� �������� ������������ Dockerfile, ��������� �� ��� ������ ���������������� ����.

�������� ������� ����� ������������� Dockerfile �� Arch Linux c ����������� ��� ����������������.

```
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:vincent-c/ponysay && \
    apt-get update
 
RUN apt-get install -y ponysay

ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology�]
```
��� ��������� ������, ��� ���������� ������������:

* ���������� ���� Dockerfile

**_������ �� [Dockerfile](https://github.com/anna-maksimovna/devops-netology/tree/main/dockerfiles/netology-ponysay)_**

* �������� ������ ��������� ������ ����� ������� ���������� �� ������ �������� ������

![ ](docker05_04_1.jpg)

* ������ �� ����� � ����� ��������� docker-hub

**_������ �� [�����-����](https://hub.docker.com/r/anutkafluff/netology-ponysay)_**