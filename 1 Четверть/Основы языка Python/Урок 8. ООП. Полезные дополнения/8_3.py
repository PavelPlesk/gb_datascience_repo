# Создайте собственный класс-исключение, который должен проверять содержимое списка на
# наличие только чисел. Проверить работу исключения на реальном примере. Запрашивать у
# пользователя данные и заполнять список необходимо только числами. Класс-исключение
# должен контролировать типы данных элементов списка.
# Примечание: длина списка не фиксирована. Элементы запрашиваются бесконечно, пока
# пользователь сам не остановит работу скрипта, введя, например, команду «stop». При этом
# скрипт завершается, сформированный список с числами выводится на экран.
# Подсказка: для этого задания примем, что пользователь может вводить только числа и строки.
# Во время ввода пользователем очередного элемента необходимо реализовать проверку типа
# элемента. Вносить его в список, только если введено число. Класс-исключение должен не
# позволить пользователю ввести текст (не число) и отобразить соответствующее сообщение.
# При этом работа скрипта не должна завершаться.

class NoDigit(Exception):
    def __str__(self):
        return "Введенные данные не являются числом или стоп-словом (Stop)!"


result = []
while True:
    try:
        new_el = input("Введите данные: ")
        if new_el.isdigit():
            result.append(new_el)
        elif new_el in ["Stop", "stop"]:
            break
        else:
            raise NoDigit
    except NoDigit:
        print(NoDigit())
print(result)
