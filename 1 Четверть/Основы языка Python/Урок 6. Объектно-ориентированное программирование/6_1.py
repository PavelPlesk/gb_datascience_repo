from itertools import cycle
from time import sleep
from tkinter import *


class TrafficLight:
    sequency_active = [["grey", "grey", "green"], ["grey", "yellow", "grey"], ["red", "grey", "grey"],
                       ["red", "yellow", "grey"]]
    sequency_disable = [["grey", "grey", "grey"], ["grey", "yellow", "grey"]]

    def __init__(self, _title):
        self.window = Tk()
        self.window.title(_title)
        self.window.geometry('250x450')
        self.canvas = Canvas(self.window, height=450, width=250)
        self.canvas.pack()
        self.red_id = self.canvas.create_oval(70, 20, 180, 130, outline="black", fill="red", width=2)
        self.yellow_id = self.canvas.create_oval(70, 150, 180, 260, outline="black", fill="yellow", width=2)
        self.green_id = self.canvas.create_oval(70, 280, 180, 390, outline="black", fill="green", width=2)

    def colors_set(self, _colors):
        self.canvas.itemconfig(self.red_id, fill=_colors[0])
        self.canvas.itemconfig(self.yellow_id, fill=_colors[1])
        self.canvas.itemconfig(self.green_id, fill=_colors[2])

    def running(self, _able=True, green_p=10, red_p=7, yellow_p=2):
        if not _able:
            present_colors = cycle(self.sequency_disable)
            while True:
                try:
                    self.colors_set(next(present_colors))
                    sleep(1)
                    self.window.update()
                except:
                    break
        else:
            present_colors = cycle(self.sequency_active)
            pause = cycle([green_p, yellow_p, red_p, yellow_p])
            while True:
                try:
                    self.colors_set(next(present_colors))
                    self.window.update()
                    sleep(next(pause))
                except:
                    break


tl_1 = TrafficLight("Светофор №1")
tl_1.running(0, 5, 7)
