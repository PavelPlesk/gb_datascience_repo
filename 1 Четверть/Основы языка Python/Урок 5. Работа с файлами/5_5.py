# Создать (программно) текстовый файл, записать в него программно набор чисел, разделённых
# пробелами. Программа должна подсчитывать сумму чисел в файле и выводить её на экран.

from random import randint

with open('5_5.txt', 'w+', encoding='utf-8') as f:
    f.write(' '.join(str(randint(1, 100)) for _ in range(1, randint(5, 20))))
    # f.write('1 2 3')
    f.seek(0)
    print(sum([int(n) for n in f.read().split()]))
