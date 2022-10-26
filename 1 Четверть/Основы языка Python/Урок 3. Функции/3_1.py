# Реализовать функцию, принимающую два числа (позиционные аргументы) и выполняющую их
# деление. Числа запрашивать у пользователя, предусмотреть обработку ситуации деления на
# ноль.

def division(divident, divisor):
    while not divisor:
        divisor = int(input('Деление на ноль запрещено!!! Введите делитель: '))
    return divident / divisor


while True:
    try:
        divident = float(input("Введите делимое: "))
        break
    except ValueError:
        print('Недопустимое значение! Необходимо ввести число!')
while True:
    try:
        divisor = float(input("Введите делитель: "))
        break
    except ValueError:
        print('Недопустимое значение! Необходимо ввести число!')
print(f'Результат деления равен {division(divident, divisor):.3f}')
