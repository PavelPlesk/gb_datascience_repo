# Пользователь вводит целое положительное число. Найдите самую большую цифру в числе.
# Для решения используйте цикл while и арифметические операции.

n = int(input('Введите целое положительное число: '))

biggest_digit = n % 10

while n // 10:
    n = n // 10
    next_digit = n % 10
    if next_digit > biggest_digit:
        biggest_digit = next_digit

print(biggest_digit)
