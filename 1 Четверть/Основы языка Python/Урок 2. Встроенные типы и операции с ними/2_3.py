# Пользователь вводит месяц в виде целого числа от 1 до 12. Сообщить, к какому времени года
# относится месяц (зима, весна, лето, осень). Напишите решения через list и dict.

# Вариант 1. Используем списки.
spring = ['Весна', 3, 4, 5]
summer = ['Лето', 6, 7, 8]
fall = ['Осень', 9, 10, 11]
winter = ['Зима', 12, 1, 2]
year = [spring, summer, fall, winter]
month = int(input('Введите номер месяца:'))
while month not in range(1, 13):
    month = int(input('Введите число от 1 до 12: '))
for i in year:
    if month in i:
        print(i[0])
        break

# Вариант 2. Используем словарь.
year = {1: 'Зима', 2: 'Зима', 3: 'Весна', 4: 'Весна',
        5: 'Весна', 6: 'Лето', 7: 'Лето', 8: 'Лето',
        9: 'Осень', 10: 'Осень', 11: 'Осень', 12: 'Зима'}
month = int(input('Введите номер месяца:'))
while month not in range(1, 13):
    month = int(input('Введите число от 1 до 12: '))
print(year.get(month))

# Вариант 3. Используем словарь и списки.
spring = [3, 4, 5]
summer = [6, 7, 8]
fall = [9, 10, 11]
winter = [12, 1, 2]
year = {'Весна': spring, 'Лето': summer, 'Осень': fall, 'Зима': winter}
month = int(input('Введите номер месяца:'))
while month not in range(1, 13):
    month = int(input('Введите число от 1 до 12: '))
for i in year.keys():
    if month in year.get(i):
        print(i)
        break