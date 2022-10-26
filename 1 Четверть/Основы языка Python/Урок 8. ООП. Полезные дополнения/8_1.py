# Реализовать класс «Дата», функция-конструктор которого должна принимать дату в виде
# строки формата «день-месяц-год». В рамках класса реализовать два метода. Первый, с
# декоратором @classmethod. Он должен извлекать число, месяц, год и преобразовывать их тип
# к типу «Число». Второй, с декоратором @staticmethod, должен проводить валидацию числа,
# месяца и года (например, месяц — от 1 до 12). Проверить работу полученной структуры на
# реальных данных.

class Date:
    def __init__(self, input_data):
        self.input_data = input_data
        self.date = self.unpack(input_data)

    @classmethod
    def unpack(cls, date):
        return cls.validation([int(i) for i in date.split("-")])

    @staticmethod
    def validation(date):
        common_year = {1: 31, 2: 28, 3: 31, 4: 30, 5: 31, 6: 30, 7: 31, 8: 31, 9: 30, 10: 31, 11: 30, 12: 31}
        leap_year = {1: 31, 2: 29, 3: 31, 4: 30, 5: 31, 6: 30, 7: 31, 8: 31, 9: 30, 10: 31, 11: 30, 12: 31}
        if date[1] in range(1, 13):
            if (date[0] not in range(1, common_year.get(date[1]) + 1) and date[2] % 4) or \
                    (date[0] not in range(1, leap_year.get(date[1]) + 1) and date[2] % 4 == 0):
                print("Число введено неверно!")
                return
            else:
                print(f"{date[0]:02}.{date[1]:02}.{date[2]}")
                return date
        else:
            print("Номер месяца введен неверно!")
            return


date_1 = Date("30-09-2022")
print(date_1.date)
# print(type(date_1.date[0]))
Date.unpack("1-10-2017")
