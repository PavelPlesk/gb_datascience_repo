# Создать класс TrafficLight (светофор).
# ● определить у него один атрибут color (цвет) и метод running (запуск);
# ● атрибут реализовать как приватный;
# ● в рамках метода реализовать переключение светофора в режимы: красный, жёлтый,
# зелёный;
# ● продолжительность первого состояния (красный) составляет 7 секунд, второго
# (жёлтый) — 2 секунды, третьего (зелёный) — на ваше усмотрение;
# ● переключение между режимами должно осуществляться только в указанном порядке
# (красный, жёлтый, зелёный);
# ● проверить работу примера, создав экземпляр и вызвав описанный метод.
# Задачу можно усложнить, реализовав проверку порядка режимов. При его нарушении
# выводить соответствующее сообщение и завершать скрипт.

from itertools import cycle
from time import sleep


class TrafficLight():
    color = ["Зелёный", "Желтый", "Красный", "Красный и желтый"]

    def running(self, first_color=None, green_p=10, red_p=7, yellow_p=2):
        present_color = cycle(self.color)
        pause = cycle([green_p, yellow_p, red_p, yellow_p])
        if first_color not in self.color:
            while True:
                print("Желтый")
                sleep(2)
                print("Не горит")
                sleep(2)
        else:
            while first_color != next(present_color):
                next(pause)
            print(first_color)
            sleep(next(pause))
            while True:
                print(next(present_color))
                sleep(next(pause))


tl_1 = TrafficLight()
tl_1.running("Зелёный", 5, 7)
