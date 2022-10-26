# Создать текстовый файл (не программно), сохранить в нём несколько строк, выполнить
# подсчёт строк и слов в каждой строке.

import pymorphy2

f = open('5_1.txt', 'r', encoding='utf-8')
f_strings = f.readlines()
f.close()
_stroki = pymorphy2.MorphAnalyzer().parse('строки')[0]
print(f'В файле {f.name} {len(f_strings)} {_stroki.make_agree_with_number(len(f_strings)).word}:')
_slovo = pymorphy2.MorphAnalyzer().parse('слово')[0]
for _string, i in zip(f_strings, range(1, len(f_strings) + 1)):
    print(f'{i} строка - {len(_string.split())} {_slovo.make_agree_with_number(len(_string.split())).word}')
