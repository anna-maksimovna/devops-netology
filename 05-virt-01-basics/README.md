## Задача 1
Вкратце опишите, как вы поняли - в чем основное отличие паравиртуализации и виртуализации на основе ОС.
### Ответ:
Основное отличие паравиртуализации от полной виртуализации в том, что если гостевая система совместима с основной, то большинство системных вызовов будет проходить в обход Hypervisor, что повышает производительность.

## Задача 2
Выберите тип один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:

физические сервера
паравиртуализация
виртуализация уровня ОС
Условия использования:

* Высоконагруженная база данных, чувствительная к отказу
* Различные Java-приложения
* Windows системы для использования Бухгалтерским отделом
* Системы, выполняющие высокопроизводительные расчеты на GPU

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.
### Ответ:
* Высоконагруженная база данных, чувствительная к отказу - Паравиртуализация, потому что виртуализация уровня ОС имеет минус по части отказоустойчивости, а в сравнении с полной при паравиртуализации будет выше производительность.
* Различные Java-приложения - Виртуализация уровня ОС, потому что легко администрировать, изолированы друг от друга, при этом могут переиспользовать ресурсы.
* Windows системы для использования Бухгалтерским отделом - Полная или Паравиртуализация(при условии, что основная ОС тоже Windows), потому что контейнеры представляют собой Linux-системы, что в данном случае неудобно.
* Системы, выполняющие высокопроизводительные расчеты на GPU - С расчетами на GPU не знакома, посмотрела примерно что это такое, как я понимаю: основная задача такой технологии - это многопоточность при расчетах. Можно использовать виртуализацию на основе ОС, поскольку она не ограничена в ресурсах и может использовать всю мощь хоста.

## Задача 3
Как вы думаете, возможно ли совмещать несколько типов виртуализации на одном сервере? Приведите пример такого совмещения.
### Ответ:
Да, можно совмещать. Пример: можно настроить гостевую машину по принципу паравиртуализации, например. И в рамках этой гостевой ОС развернуть контейнеры.