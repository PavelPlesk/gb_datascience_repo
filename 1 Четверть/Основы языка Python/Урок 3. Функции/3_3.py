# Реализовать функцию my_func(), которая принимает три позиционных аргумента и
# возвращает сумму наибольших двух аргументов.

def my_func(*args):
    return sum(args) - min(args)


while True:
    try:
        arg_1 = float(input('Введите число №1: '))
        break
    except ValueError:
        print('Недопустимое значение! Необходимо ввести число!')
while True:
    try:
        arg_2 = float(input('Введите число №2: '))
        break
    except ValueError:
        print('Недопустимое значение! Необходимо ввести число!')
while True:
    try:
        arg_3 = float(input('Введите число №3: '))
        break
    except ValueError:
        print('Недопустимое значение! Необходимо ввести число!')

print(my_func(arg_1, arg_2, arg_3))
