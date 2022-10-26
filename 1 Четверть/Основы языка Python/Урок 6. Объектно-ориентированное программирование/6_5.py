# Реализовать класс Stationery (канцелярская принадлежность).
# ● определить в нём атрибут title (название) и метод draw (отрисовка). Метод выводит
# сообщение «Запуск отрисовки»;
# ● создать три дочерних класса Pen (ручка), Pencil (карандаш), Handle (маркер);
# ● в каждом классе реализовать переопределение метода draw. Для каждого класса
# метод должен выводить уникальное сообщение;
# ● создать экземпляры классов и проверить, что выведет описанный метод для каждого
# экземпляра.

class Stationery():
    title = None

    def draw(self):
        return print("Запуск отрисовки.")


class Pen(Stationery):
    def draw(self):
        return print(f"Создание подписи. Используется {self.title}")


class Pencil(Stationery):
    def draw(self):
        return print(f"Создание чертежа. Используется {self.title}")


class Handle(Stationery):
    def draw(self):
        return print(f"Выделение. Используется {self.title}")


_pen = Pen()
_pen.title = "ручка"
_pen.draw()

_pencil = Pencil()
_pencil.title = "простой карандаш"
_pencil.draw()

_handle = Handle()
_handle.title = "желтый выделитель"
_handle.draw()
