# Создайте собственный класс-исключение, обрабатывающий ситуацию деления на ноль.
# Проверьте его работу на данных, вводимых пользователем. При вводе нуля в качестве
# делителя программа должна корректно обработать эту ситуацию и не завершиться с ошибкой.

class Zerodivider(Exception):
    def __str__(self):
        return "Ошибка! Деление на ноль невозможно."

while True:
    try:
        a=int(input("Введите делимое: "))
        break
    except ValueError:
        print("Ошибка! Необходимо ввести число!")
while True:
    try:
        b=int(input("Введите делитель: "))
        if b==0:
            raise Zerodivider()
        else:
            break
    except Zerodivider:
        print(Zerodivider())
    except ValueError:
        print("Ошибка! Необходимо ввести число!")
print(f"{a / b:.2f}")
