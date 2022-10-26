import datetime
import os
import re

class Logger(object):

    def __new__(cls, path="./log/"):
        if not hasattr(cls, 'instance'):
            cls.instance = super(Logger, cls).__new__(cls)
        return cls.instance

    def __init__(self, path="./log/"):
        try:
            with open("log_info", "r") as f:
                self.__path = f.readlines()[0]
                self.__last_event = f.readlines()[1]
        except:
            self.__path = path
            self.__last_event = 'No events'
            with open("log_info", "w") as f:
                f.writelines(f'{self.path}\n{self.__last_event}\n')

    @property
    def path(self):
        return self.__path

    @path.setter
    def path(self, value):
        self.__path = value
        with open("log_info", "w") as f:
            f.writelines(f'{self.__path}\n{self.__last_event}\n')

    @property
    def last_event(self):
        return self.__last_event

    @last_event.setter
    def last_event(self, value):
        self.__last_event = value
        with open("log_info", "w") as f:
            f.writelines(f'{self.__path}\n{self.__last_event}\n')

    @property
    def curr_log(self):
        return f'{self.path}log_{self.curr_date()}'

    @staticmethod
    def curr_date():
        return datetime.date.today().strftime("%d.%m.%Y")

    @staticmethod
    def curr_time():
        return datetime.datetime.now().strftime("%H:%M:%S")

    def write_log(self, text):
        try:
            f = open(self.curr_log, 'a', encoding='utf-8')
        except FileNotFoundError:
            os.mkdir(self.path)
            f = open(self.curr_log, 'a', encoding='utf-8')
        f.write(f'[{self.curr_time()}] {text}\n')
        f.close()
        self.last_event = f"{self.curr_date()} {self.curr_time()} {text}"

    def clear_log(self):
        if os.path.exists(self.curr_log):
            open(self.curr_log, 'w', encoding='utf-8').close()

    def get_logs(self):
        logs = []
        if os.path.exists(self.curr_log):
            with open(self.curr_log, 'r', encoding='utf-8') as f:
                data = [(line.split()[0][1:-1], line.split()[1][:-1]) for line in f.readlines()]
                logs.extend(data)
        return logs

    def get_last_event(self):
        return self.last_event

    def get_all_logs(self):
        files = [file for file in os.listdir(self.path)
                 if re.match("log_[0-9][0-9].[0.9][0-9].[0-9][0-9][0-9][0-9]", file)]
        return files

# a = Logger("./log/")
# a.write_log("test")
# a.write_log("test2")
# a.get_last_event()
pass
