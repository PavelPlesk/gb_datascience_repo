import random
import webbrowser

number = int(random.random() * 10)
bid = int(input("Угадай, какое число я загадал? "))

while bid != number:
    if bid > number:
        bid = int(input("Нет. Мое число меньше."))
    if bid < number:
        bid = int(input("Нет. Мое число больше."))

print("Правильно!", number)
webbrowser.open('https://www.youtube.com/watch?v=C345jMzdhvg')