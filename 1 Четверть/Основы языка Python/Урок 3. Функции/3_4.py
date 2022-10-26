# Программа принимает действительное положительное число x и целое отрицательное число
# y. Выполните возведение числа x в степень y. Задание реализуйте в виде функции
# my_func(x, y). При решении задания нужно обойтись без встроенной функции возведения
# числа в степень.

def my_func1(x, y):
    return x ** y


def my_func2(x, y):
    res = 1
    for i in range(1, abs(y) + 1):
        res /= x
    return res


while True:
    try:
        x = float(input('Введите число №1: '))
        while x <= 0:
            x = float(input('Недопустимое значение! Число №1 должно быть положительным: '))
        break
    except ValueError:
        print('Недопустимое значение! Необходимо ввести число!')

while True:
    try:
        y = float(input('Введите число №2: '))
        while y >= 0 or y % 1 != 0:
            y = float(input('Недопустимое значение! Число №2 должно быть целым отрицательным: '))
        break
    except ValueError:
        print('Недопустимое значение! Необходимо ввести число!')

print(my_func1(x, y))
print(my_func2(x, int(y)))
