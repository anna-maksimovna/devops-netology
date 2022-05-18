# �������� ������� � ������� "8.4 ������ � Roles"

[����������� � Playbook](https://github.com/anna-maksimovna/ansible-roles)

[����������� � Kibana-role](https://github.com/anna-maksimovna/kibana-role)

[����������� � Filebeat-role](https://github.com/anna-maksimovna/filebeat-role)


�.�. ���������� �� � ���� ���� ������� �� ���������� ������ playbook, �� ��� �� ������ ����� �� ���������� ������

> ### ���������� � ����������
> �������� ��� ������ ��������� ����������� � ����� ���� �������: kibana-role � filebeat-role.
> �������� ��������� ����� ������ ����� � ������ ������� � github.
> ### �������� �����
>  ���� �������� ���� - ������� ��� playbook �� ��������� roles. ������: ������� roles ��� elastic, kibana, filebeat � �������� playbook ��� ������������� ���� �����. ��������� ���������: ���������� ��� ����� ����������� � roles � ���� ����������� � playbook.

> 1. ������� � ������ ������ playbook ���� requirements.yml � ��������� ��� ��������� ����������:
> ---
>   - src: git@github.com:netology-code/mnt-homeworks-ansible.git
>     scm: git
>    version: "2.1.4"
>     name: elastic 

![ ](ans08_04_1.png)

> 2. ��� ������ ansible-galaxy ������� ���� ��� ����.
> 3. ������� ����� ������� � ����� ��� ������ ansible-galaxy role init kibana-role.

![ ](ans08_04_2.png)

> 4. �� ������ tasks �� ������� playbook ��������� ����� role. ��������� ���������� ����� vars � default.
> 5. ��������� ������ ������� �������� � templates.
> 6. ������� ����� ������� � ����� ��� ������ ansible-galaxy role init filebeat-role.

![ ](ans08_04_3.png)

> 7. �� ������ tasks �� ������� playbook ��������� ����� role. ��������� ���������� ����� vars � default.
> 8. ��������� ������ ������� �������� � templates.
> 9. ������� � README.md ��� ���� � �� ���������.
> 10. �������� ��� roles � �����������. ���������� ����, ��������� ������������� ���������.
> 11. �������� roles � requirements.yml � playbook.

![ ](ans08_04_4.png)

> 12. ������������� playbook �� ������������� roles.
> 13. �������� playbook � �����������.
> 14. � ����� ��������� ������ �� ��� ����������� � roles � ���� ������ �� ����������� � playbook.