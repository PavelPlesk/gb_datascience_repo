# Пользователь вводит время в секундах. Переведите время в часы, минуты, секунды и
# выведите в формате чч:мм:сс. Используйте форматирование строк.

time_in_seconds = int(input('Введите время в секундах: '))

hours = time_in_seconds // 3600
minutes = time_in_seconds % 3600 // 60
seconds = time_in_seconds % 60

print('%.2d:%.2d:%.2d' % (hours, minutes, seconds))
print('{:02}:{:02}:{:02}'.format(hours, minutes, seconds))
print(f'{hours:02}:{minutes:02}:{seconds:02}')
