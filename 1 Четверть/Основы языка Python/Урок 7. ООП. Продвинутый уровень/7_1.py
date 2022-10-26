# Реализовать класс Matrix (матрица). Обеспечить перегрузку конструктора класса (метод __init__()),
# который должен принимать данные (список списков) для формирования матрицы.
# Подсказка: матрица — система некоторых математических величин, расположенных в виде прямоугольной схемы.
# Следующий шаг — реализовать перегрузку метода __str__() для вывода матрицы в привычном виде.
# Далее реализовать перегрузку метода __add__() для реализации операции сложения двух объектов класса Matrix
# (двух матриц). Результатом сложения должна быть новая матрица.
# Подсказка: сложение элементов матриц выполнять поэлементно — первый элемент первой строки первой матрицы
# складываем с первым элементом первой строки второй матрицы и т.д.

class Matrix:
    def __init__(self, matrix):
        self.matrix = matrix
        self.row_len_chek()

    def row_len_chek(self):  # Приведение матрицы к прямоугольному виду
        max_row = max([len(i) for i in self.matrix])
        zero_add = False
        for el in self.matrix:
            if len(el) < max_row:
                for _ in range(len(el), max_row):
                    el.append(0)
                    zero_add = True
        if zero_add:
            print(
                "Некорректные данные! Матрица приведена к прямоугольному виду: строки дополнены нулями.")

    def __str__(self):
        max_len = max([len(str(k)) for i in self.matrix for k in i])
        return "\n".join(["  ".join([" " * (max_len - len(str(k))) + str(k) for k in i]) for i in self.matrix]) + "\n"

    def __add__(self, other):
        if len(self.matrix) == len(other.matrix) and len(self.matrix[0]) == len(other.matrix[0]):
            return Matrix([[self.matrix[i][k] + other.matrix[i][k] for k in range(0, len(self.matrix[0]))] for i in
                           range(0, len(self.matrix))])
        else:
            print("Ошибка! Невозможно сложить разноразмерные матрицы!")


matrix_1 = Matrix([[1, 8, 6], [3, 4, 5, 9], [1, 2]])
print(matrix_1)
matrix_2 = Matrix([[1, 8, 0, 8], [3, 4, 15, 2], [1, 2, 12, 2]])
print(matrix_2)
print(matrix_1 + matrix_2)
