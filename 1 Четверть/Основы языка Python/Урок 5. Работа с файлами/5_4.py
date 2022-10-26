# Создать (не программно) текстовый файл со следующим содержимым:
# One — 1
# Two — 2
# Three — 3
# Four — 4
# Напишите программу, открывающую файл на чтение и считывающую построчно данные. При
# этом английские числительные должны заменяться на русские. Новый блок строк должен
# записываться в новый текстовый файл

from googletrans import Translator

with open('text_4.txt', 'r', encoding='utf-8') as f:
    ru_file = Translator().translate(f.read(), dest='ru')
with open('text_4_ru.txt', 'w', encoding='utf-8') as f:
    f.write(''.join(ru_file.text.split('.')))
