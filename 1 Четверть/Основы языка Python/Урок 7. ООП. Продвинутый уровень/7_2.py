# Реализовать проект расчета суммарного расхода ткани на производство одежды.
# Основная сущность (класс) этого проекта — одежда, которая может иметь определенное название.
# К типам одежды в этом проекте относятся пальто и костюм. У этих типов одежды существуют параметры:
# размер (для пальто) и рост (для костюма). Это могут быть обычные числа: V и H, соответственно.
# Для определения расхода ткани по каждому типу одежды использовать формулы: для пальто (V/6.5 + 0.5),
# для костюма (2*H + 0.3). Проверить работу этих методов на реальных данных.
# Реализовать общий подсчет расхода ткани. Проверить на практике полученные на этом уроке знания:
# реализовать абстрактные классы для основных классов проекта, проверить на практике работу декоратора @property.

from abc import ABC, abstractmethod


class Clothes(ABC):
    @abstractmethod
    def consumption(self):
        pass

    def __add__(self, other):
        return Temp(self.consumption + other.consumption)

    def __mul__(self, other):
        return Temp(self.consumption * other)

    def __str__(self):
        return f"{self.consumption:.2f}"


class Temp(Clothes):
    def __init__(self, consumption):
        self.temp = consumption

    @property
    def consumption(self):
        return self.temp


class Coat(Clothes):
    def __init__(self, size):
        self.size = size

    @property
    def consumption(self):
        return self.size / 6.5 + 0.5


class Suit(Clothes):
    def __init__(self, height):
        self.height = height

    @property
    def consumption(self):
        return 2 * self.height + 0.3


my_coat = Coat(48)
print(my_coat)
my_suit = Suit(1.92)
print(my_suit)
print(my_suit + my_coat)
print(Coat(44) * 2 + Coat(46) * 3 + Coat(48) + Suit(1.76) * 3 + Suit(1.83) * 2)
