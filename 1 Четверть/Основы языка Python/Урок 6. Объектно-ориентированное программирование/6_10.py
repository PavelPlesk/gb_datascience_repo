from itertools import cycle
from time import sleep
from tkinter import *


class TrafficLight(Tk):
    color = ["Зелёный", "Желтый", "Красный", "Красный и желтый"]

    def __init__(self, _title):
        super().__init__()
        self.title(_title)
        self.geometry('250x450')
        self.canvas = Canvas(self)
        self.canvas.pack()
        self.red_id = self.canvas.create_oval(65, 10, 175, 120, outline="black", fill="red", width=2)
        self.yellow_id = self.canvas.create_oval(65, 140, 175, 250, outline="black", fill="yellow", width=2)
        self.green_id = self.canvas.create_oval(65, 270, 175, 380, outline="black", fill="green", width=2)
        # self.color_set()
        # self.mainloop()

    def color_set(self, red="red", yellow="yellow", green="green"):
        self.canvas.itemconfig(self.red_id, fill=red)
        self.canvas.itemconfig(self.yellow_id, fill=yellow)
        self.canvas.itemconfig(self.green_id, fill=green)



    def running(self, first_color=None, green_p=10, red_p=7, yellow_p=2):
        present_color = cycle(self.color)
        pause = cycle([green_p, yellow_p, red_p, yellow_p])
        if first_color not in self.color:
            while True:
                self.color_set("grey", "grey", "grey")
                sleep(2)
                self.color_set("grey", "yellow", "grey")
                sleep(2)
                self.mainloop()

        else:
            while first_color != next(present_color):
                next(pause)
            print(first_color)
            sleep(next(pause))
            while True:
                print(next(present_color))
                sleep(next(pause))


tl_1 = TrafficLight("Светофор №1")
tl_1.running("", 5, 7)

