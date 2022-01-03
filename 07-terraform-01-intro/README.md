## Задача 1. Выбор инструментов.
#### Легенда
Через час совещание на котором менеджер расскажет о новом проекте. Начать работу над которым надо будет уже сегодня. На данный момент известно, что это будет сервис, который ваша компания будет предоставлять внешним заказчикам. Первое время, скорее всего, будет один внешний клиент, со временем внешних клиентов станет больше.

Так же по разговорам в компании есть вероятность, что техническое задание еще не четкое, что приведет к большому количеству небольших релизов, тестирований интеграций, откатов, доработок, то есть скучно не будет.

Вам, как девопс инженеру, будет необходимо принять решение об инструментах для организации инфраструктуры. На данный момент в вашей компании уже используются следующие инструменты:

* остатки Сloud Formation,
* некоторые образы сделаны при помощи Packer,
* год назад начали активно использовать Terraform,
* разработчики привыкли использовать Docker,
* уже есть большая база Kubernetes конфигураций,
* для автоматизации процессов используется Teamcity,
* также есть совсем немного Ansible скриптов,
* и ряд bash скриптов для упрощения рутинных задач.
Для этого в рамках совещания надо будет выяснить подробности о проекте, что бы в итоге определиться с инструментами:

1. Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
2. Будет ли центральный сервер для управления инфраструктурой?
3. Будут ли агенты на серверах?
4. Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?

В связи с тем, что проект стартует уже сегодня, в рамках совещания надо будет определиться со всеми этими вопросами.

В результате задачи необходимо
1. Ответить на четыре вопроса представленных в разделе "Легенда".
2. Какие инструменты из уже используемых вы хотели бы использовать для нового проекта?
3. Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?

Если для ответа на эти вопросы недостаточно информации, то напишите какие моменты уточните на совещании.

### Ответ:
1. Ответы по легенде:
   1. Думаю лучше неизменяемый тип инфраструктуры, т.к. много доработок планируется и т.д., лучше просто новый образ деплоить и все.
   2. На первое время можно обойтись и без центрального сервера, чтобы не тратить время и силы на него.
   3. Удобнее без агентов.
   4. Использовать средства инициализаци ресурсов.

2. Инструменты:
   * Packer
   * Terraform
   * Docker
   * Kubernetes
   * Teamcity

3. Внедрение новых инструментов:
В принципе уже имеющихся инструментов должно хватить, но возможно рассмотреть и какие-то новые инструменты.






## Задача 2 Установка терраформ.
Официальный сайт: https://www.terraform.io/

Установите терраформ при помощи менеджера пакетов используемого в вашей операционной системе. В виде результата этой задачи приложите вывод команды terraform --version.

### Ответ:
![ ](ter07_01_1.jpg)

## Задача 3 Поддержка легаси кода.
В какой-то момент вы обновили терраформ до новой версии, например с 0.12 до 0.13. А код одного из проектов настолько устарел, что не может работать с версией 0.13. В связи с этим необходимо сделать так, чтобы вы могли одновременно использовать последнюю версию терраформа установленную при помощи штатного менеджера пакетов и устаревшую версию 0.12.

В виде результата этой задачи приложите вывод --version двух версий терраформа доступных на вашем компьютере или виртуальной машине.

### Ответ:
Сделала по [инструкции](https://coderoad.ru/60113774/%D0%9A%D0%B0%D0%BA-%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%B8%D1%82%D1%8C-%D0%BD%D0%B5%D1%81%D0%BA%D0%BE%D0%BB%D1%8C%D0%BA%D0%BE-%D0%B8%D0%BB%D0%B8-%D0%B4%D0%B2%D0%B5-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B8-Terraform)
![ ](ter07_01_2.jpg)