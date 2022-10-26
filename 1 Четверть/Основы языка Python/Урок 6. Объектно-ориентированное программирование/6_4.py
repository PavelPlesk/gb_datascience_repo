# Реализуйте базовый класс Car.
# ● у класса должны быть следующие атрибуты: speed, color, name, is_police (булево). А
# также методы: go, stop, turn(direction), которые должны сообщать, что машина
# поехала, остановилась, повернула (куда);
# ● опишите несколько дочерних классов: TownCar, SportCar, WorkCar, PoliceCar;
# ● добавьте в базовый класс метод show_speed, который должен показывать текущую
# скорость автомобиля;
# ● для классов TownCar и WorkCar переопределите метод show_speed. При значении
# скорости свыше 60 (TownCar) и 40 (WorkCar) должно выводиться сообщение о
# превышении скорости.
# Создайте экземпляры классов, передайте значения атрибутов. Выполните доступ к атрибутам,
# выведите результат. Вызовите методы и покажите результат.

class Car():
    def __init__(self, name, color, is_police=False):
        self.color = color
        self.name = name
        self.is_police = is_police

    def go(self, new_speed=90):
        self.speed = new_speed
        return print(f"{self.color} {self.name} движется со скоростью {self.speed} км/ч.")

    def stop(self):
        self.speed = 0
        return print(f"{self.color} {self.name} остановился.")

    def turn(self, direction):
        return print(f"{self.color} {self.name} повернул {direction}.")

    def show_speed(self):
        return print(f"{self.speed} км/ч.")


class TownCar(Car):
    def show_speed(self):
        if self.speed <= 60:
            return print(f"{self.speed} км/ч.")
        else:
            return print(f"{self.speed} км / ч. Превышение разрешенной скорости!")


class SportCar(Car):
    pass


class WorkCar(Car):
    pass

    def show_speed(self):
        if self.speed <= 40:
            return print(f"{self.speed} км/ч.")
        else:
            return print(f"{self.speed} км / ч. Превышение разрешенной скорости!")


class PoliceCar(Car):
    pass


auto_1 = Car("Мерседес", "Красный")
auto_1.go(120)
auto_1.show_speed()
auto_1.turn("налево")
auto_1.show_speed()
auto_1.stop()
auto_1.show_speed()

auto_2 = TownCar("Фольксваген", "Серый")
auto_2.go(30)
auto_2.show_speed()
auto_2.go(120)
auto_2.show_speed()
auto_2.stop()
auto_2.show_speed()

auto_3 = SportCar("Феррари", "Желтый")
auto_3.go(30)
auto_3.show_speed()
auto_3.go(120)
auto_3.show_speed()
auto_3.stop()
auto_3.show_speed()

auto_4 = PoliceCar("полицейский автомобиль", "Синий")
auto_4.go(30)
auto_4.show_speed()
auto_4.go(120)
auto_4.show_speed()
auto_4.stop()
auto_4.show_speed()

auto_5 = WorkCar("ГАЗ", "Синий")
auto_5.go(30)
auto_5.show_speed()
auto_5.go(120)
auto_5.show_speed()
auto_5.stop()
auto_5.show_speed()
