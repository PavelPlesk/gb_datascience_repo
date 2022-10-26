# Создать текстовый файл (не программно). Построчно записать фамилии сотрудников и
# величину их окладов (не менее 10 строк). Определить, кто из сотрудников имеет оклад менее
# 20 тысяч, вывести фамилии этих сотрудников. Выполнить подсчёт средней величины дохода
# сотрудников.
# Пример файла:
# Иванов 23543.12
# Петров 13749.32

f = open('text_3.txt', 'r', encoding='utf-8')
staff_salary = {el.split()[0]: float(el.split()[1]) for el in f.readlines()}
f.close()
salry_less20 = [staff for staff, salary in staff_salary.items() if salary < 20000]
print(f'Следующие сотрудники имеют оклад менее 20000: {", ".join(salry_less20)}.')
print(f'Средняя зарплата на предприятии - {sum(staff_salary.values()) / len(staff_salary):.2f}')
