# Представлен список чисел. Необходимо вывести элементы исходного списка, значения
# которых больше предыдущего элемента.
# Подсказка: элементы, удовлетворяющие условию, оформить в виде списка. Для его
# формирования используйте генератор.
# Пример исходного списка: [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55].
# Результат: [12, 44, 4, 10, 78, 123].

from random import randint

# my_list=[300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55]
my_list = [randint(1, 1000) for i in range(1, randint(5, 25))]

new_list = [el2 for el1, el2 in zip(my_list, my_list[1:]) if el2 > el1]

print(my_list)
print(new_list)
