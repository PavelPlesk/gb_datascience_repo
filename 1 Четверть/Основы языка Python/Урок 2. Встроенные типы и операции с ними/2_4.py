# Пользователь вводит строку из нескольких слов, разделённых пробелами. Вывести каждое
# слово с новой строки. Строки нужно пронумеровать. Если слово длинное, выводить только
# первые 10 букв в слове.

my_string = input('Введите строку: ')
n = 1
for i in my_string.split():
    print(f'{n}. {i[:10]}')
    n += 1
