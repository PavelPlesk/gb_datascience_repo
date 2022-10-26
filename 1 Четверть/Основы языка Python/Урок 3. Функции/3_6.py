# Реализовать функцию int_func(), принимающую слова из маленьких латинских букв и
# возвращающую их же, но с прописной первой буквой. Например, print(int_func(‘text’)) -> Text.
# Продолжить работу над заданием. В программу должна попадать строка из слов, разделённых
# пробелом. Каждое слово состоит из латинских букв в нижнем регистре. Нужно сделать вывод
# исходной строки, но каждое слово должно начинаться с заглавной буквы. Используйте
# написанную ранее функцию int_func().

def int_func(_str):
    for _char in _str:
        if not ord(_char) in range(97, 123) and ord(_char) != 32:
            print('Ошибка! Необходимо ввести строку, состоящую из латинских букв в нижнем регистре и пробелов: ')
            return
    return _str.title()

new_str=int_func(input('Введите текст: '))
while new_str is None:
    new_str=int_func(input('Введите текст: '))
print(new_str)