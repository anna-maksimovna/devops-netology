# �������� ������� � ������� "09.05 Teamcity"

[�������� ����������� � ������� �� Teamcity](https://github.com/anna-maksimovna/example-teamcity)



> ### ���������� � ����������
> * � Ya.Cloud �������� ����� ������� (4CPU4RAM) �� ������ ������ jetbrains/teamcity-server
> * ��������� ������� teamcity, ��������� �������������� ���������
> * �������� ��� ���� �������(2CPU4RAM) �� ������ ������ jetbrains/teamcity-agent. ��������� � ���� ���������� ��������� SERVER_URL: "http://<teamcity_url>:8111"
> * ����������� �����
> * �������� fork �����������
> * ������� VM (2CPU4RAM) � ��������� playbook

> ### �������� �����

> * �������� ����� ������ � teamcity �� ������ fork
> * �������� autodetect ������������
> * ��������� ����������� ����, ��������� ������ ������ master'a
> * ��������� ������� ������: ���� ������ �� ����� master, �� ������ ���������� mvn clean deploy, ����� mvn clean test
> * ��� deploy ����� ���������� ��������� settings.xml � ����� ������������ maven � teamcity, �������������� ������� ���� ����� ��� ����������� � nexus
> * � pom.xml ���������� �������� ������ �� ����������� � nexus
> * ��������� ������ �� master, ��������� ��� �� ������ �������, �������� �������� � nexus
> * ���������� build configuration � �����������
> * �������� ��������� ����� feature/add_reply � �����������
> * �������� ����� ����� ��� ������ Welcomer: ����� ������ ���������� ������������ �������, ���������� ����� hunter
> * ��������� ���� ��� ������ ������ �� ����� ����� hunter � ����� �������
> * �������� push ���� ��������� � ����� ����� � �����������
> * ��������� ��� ������ �������������� �����������, ����� ������ �������
> * ������� ��������� �� ������������ ����� feature/add_reply � master ����� Merge
> * ���������, ��� ��� ���������� ��������� � ������ �� ����� master
> * ��������� ������������ ���, ����� ��� �������� .jar � ��������� ������
> * ��������� ��������� ������ �������, ���������, ��� ����� ������ ������� � ��������� �������
> * ���������, ��� ������������ � ����������� �������� ��� ��������� ������������ �� teamcity
> * � ����� ������������ ������ �� �����������