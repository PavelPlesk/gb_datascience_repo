# Начните работу над проектом «Склад оргтехники». Создайте класс, описывающий склад. А
# также класс «Оргтехника», который будет базовым для классов-наследников. Эти классы —
# конкретные типы оргтехники (принтер, сканер, ксерокс). В базовом классе определите
# параметры, общие для приведённых типов. В классах-наследниках реализуйте параметры,
# уникальные для каждого типа оргтехники.
# Продолжить работу над первым заданием. Разработайте методы, которые отвечают за приём
# оргтехники на склад и передачу в определённое подразделение компании. Для хранения
# данных о наименовании и количестве единиц оргтехники, а также других данных, можно
# использовать любую подходящую структуру (например, словарь).
# Продолжить работу над вторым заданием. Реализуйте механизм валидации вводимых
# пользователем данных. Например, для указания количества принтеров, отправленных на
# склад, нельзя использовать строковый тип данных.
# Подсказка: постарайтесь реализовать в проекте «Склад оргтехники» максимум возможностей,
# изученных на уроках по ООП.

class Storage:
    container = {}
    income = {}
    outcome = {}

    def __str__(self):
        _return = "\n"
        for group, models in self.container.items():
            _return += f"{group}:\n"
            for model, val in models.items():
                _return += (" " * 4 + model + " " * (20 - len(model)) + ":" +
                            " " * (4 - len(str(val))) + str(val) + "\n")
        return _return

    def incoming(self, obj, amount):
        try:
            if amount == 0:
                raise ZeroAmount
            int(amount)
        except ZeroAmount:
            print(ZeroAmount())
            return "No item was sent."
        except ValueError or KeyError:
            print("\n'Amount' should be a number!")
            return "No item was recieved."
        self.container.setdefault(obj.__class__.__name__, {"Total": 0})
        self.container[obj.__class__.__name__].setdefault(str(obj), 0)
        self.container[obj.__class__.__name__][str(obj)] = \
            self.container.get(obj.__class__.__name__).get(str(obj)) + amount
        self.container[obj.__class__.__name__]["Total"] = \
            self.container.get(obj.__class__.__name__).get("Total") + amount
        return f"\nReceived {amount} {str(obj)}. " \
               f"There are {self.container[obj.__class__.__name__][str(obj)]} now."

    def outcoming(self, obj, amount, destination="unknown destination"):
        try:
            if self.container.get(obj.__class__.__name__).get(str(obj)) is None:
                raise WrongItem(obj)
            if amount == 0:
                raise ZeroAmount
            int(amount)
        except WrongItem:
            print(WrongItem(obj))
            return "No item was sent."
        except ZeroAmount:
            print(ZeroAmount())
            return "No item was sent."
        except ValueError or KeyError:
            print("\n'Amount' should be a number!")
            return "No item was sent."

        if amount > self.container.get(obj.__class__.__name__).get(str(obj)):
            return_add_1 = "Not enough items on the storage. "
            return_add_2 = f", need {amount - self.container.get(obj.__class__.__name__).get(str(obj))} more"
            amount = self.container.get(obj.__class__.__name__).get(str(obj))
        else:
            return_add_1 = ""
            return_add_2 = ""
        self.container[obj.__class__.__name__][str(obj)] = \
            self.container.get(obj.__class__.__name__).get(str(obj)) - amount
        self.container[obj.__class__.__name__]["Total"] = \
            self.container.get(obj.__class__.__name__).get("Total") - amount
        _return = f"\n{return_add_1}Sent {amount} {str(obj)} to {destination}{return_add_2}. " \
                  f"There are {self.container[obj.__class__.__name__][str(obj)]} now."
        if self.container[obj.__class__.__name__][str(obj)] == 0:
            self.container[obj.__class__.__name__].pop(str(obj))
        return _return


class ElectricalApparatus:
    def __init__(self, manufacturer="", model=""):
        self.manufacturer = manufacturer
        self.model = model


class CircuitBreaker(ElectricalApparatus):
    def __init__(self, manufacturer, model, _type, current):
        super().__init__(manufacturer, model)
        self._type = self.type_check(_type)
        self.current = current

    def __str__(self):
        return f"{self.manufacturer} {self.model} {self._type}{self.current}".lstrip()

    @staticmethod
    def type_check(_type):
        if _type.upper() not in ["A", "B", "C", "D", "K", "L", "Z"]:
            print("Wrong CB type!")
            return ""
        else:
            return _type.upper()


class LightSwitch(ElectricalApparatus):
    def __init__(self, manufacturer, model, switches_amount):
        super().__init__(manufacturer, model)
        self.switches_number = switches_amount

    def __str__(self):
        return f"{self.manufacturer} {self.model}".lstrip()


class Extender(ElectricalApparatus):
    def __init__(self, manufacturer, model, length, sockets_amount=1):
        super().__init__(manufacturer, model)
        self.sockets_amount = sockets_amount
        self.length = length

    def __str__(self):
        return f"{self.manufacturer} {self.model} {self.length} m".lstrip()


class WrongItem(Exception):
    def __init__(self, obj):
        self.obj = str(obj)

    def __str__(self):
        return f"\nThere is no {str(self.obj)} on the storage!"


class ZeroAmount(Exception):
    def __str__(self):
        return f"\nYou need to enter the quantity"


cb_SE_pl7_C16 = CircuitBreaker("SE", "pl7", "C", 16)
my_storage = Storage()
my_storage.incoming(cb_SE_pl7_C16, 3)
# print(my_storage)
my_storage.incoming(CircuitBreaker("EATON", "ВА47-29", "b", 6), 15)
# print(my_storage)
my_storage.incoming(CircuitBreaker("", "", "C", 16), 10)
# print(my_storage)
my_storage.incoming(LightSwitch("SE", "s01", 1), 50)
print(my_storage.outcoming(CircuitBreaker("EATON", "ВА47-29", "b", 6), 20, "Main office"))
print(my_storage.outcoming(CircuitBreaker("EATON", "ВА47-29", "b", 6), 20, "Main office"))
# print(my_storage)
my_storage.outcoming(CircuitBreaker("EATON", "ВА47-29", "b", 6), 5, "Main office")
my_storage.incoming(CircuitBreaker("EATON", "ВА47-29", "b", 32), 1224)
my_storage.incoming(Extender("Electra", "", 10), 33)
my_storage.incoming(Extender("Electra", "", 10), 0)
print(my_storage)
