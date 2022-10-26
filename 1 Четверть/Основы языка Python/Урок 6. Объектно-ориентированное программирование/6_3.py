# Реализовать базовый класс Worker (работник).
# ● определить атрибуты: name, surname, position (должность), income (доход);
# ● последний атрибут должен быть защищённым и ссылаться на словарь, содержащий
# элементы: оклад и премия, например, {"wage": wage, "bonus": bonus};
# ● создать класс Position (должность) на базе класса Worker;
# ● в классе Position реализовать методы получения полного имени сотрудника
# (get_full_name) и дохода с учётом премии (get_total_income);
# ● проверить работу примера на реальных данных: создать экземпляры класса Position,
# передать данные, проверить значения атрибутов, вызвать методы экземпляров.

class Worker:
    name = "Иван"
    surname = "Иванов"
    position = "Инженер"
    _income = {"wage": 10000, "bonus": 5000}


class Position(Worker):
    def get_full_name(self):
        return f"{self.name} {self.surname}"

    def get_total_income(self):
        return f"Доход с учетом премии: {sum([float(n) for n in self._income.values()])}."


woker_1 = Position()
woker_1.name = "Петр"
woker_1.surname = "Петров"
woker_1._income["bonus"] = 2000
print(woker_1.get_full_name())
print(woker_1.get_total_income())
