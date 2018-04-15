import Tkinter
import tkMessageBox
import os
import subprocess


top = Tkinter.Tk()
canvas_width = 500
canvas_height = 200
w = Tkinter.Canvas(top, 
           width=canvas_width,
           height=canvas_height)

w.pack()
top.title("Loanguage X compiler".center(100))
def helloCallBack1():
	os.system('gcc autoindent autoindent.c')
	os.system('./autointend trial2.txt')
	print("hi")
	os.system('lex x.l')
	print("hello")

def helloCallBack2():
	print("resume ")
	os.system('yacc -d x.y')
	print("hi")
	os.system('lex x.l')
	print("hello")
	

def helloCallBack3():
#deletion
	os.system('gcc y.tab.c -ll -ly')
	print("hi")

	os.system('./a.out trial2')
	print("hi hi")
#start again
	helloCallBack1()

def helloCallBack4():
	os.system('lex 3ad.l')
	os.system('yacc -d 3ad.y')
	os.system('gcc y.tab.c -ll -ly')
	os.system('./a.out')

def helloCallBack5():
	os.system('lex if_3address.l')
	os.system('yacc -d if_3address.y')
	os.system('gcc y.tab.c -ll -ly')
	os.system('./a.out')


def helloCallBack6():
	top.destroy()
	
	#print("hi hi")

B1 = Tkinter.Button(top, text ="Prettify",width=25,bg="green",fg="white", command = helloCallBack1)
B2 = Tkinter.Button(top, text ="Tokenize", width=25,bg="yellow",fg="black",command = helloCallBack2)
B3 = Tkinter.Button(top, text ="Parse", width=25,bg="blue",fg="white",command = helloCallBack3)
B4 = Tkinter.Button(top, text ="3-address code for arithmetic ", width=40,bg="black",fg="white",command = helloCallBack4)
B5 = Tkinter.Button(top, text ="3-address code for arithmetic ", width=40,bg="red",fg="white",command = helloCallBack5)
B6 = Tkinter.Button(top, text ="Quit", width=25,bg="red",fg="white",command = helloCallBack6)

B1.pack()
B2.pack()
B3.pack()
B4.pack()
B5.pack()
B6.pack()
top.mainloop()

