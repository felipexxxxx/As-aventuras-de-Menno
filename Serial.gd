extends Node

const serial_res = preload("res://bin/gdserial.gdns")
var serial_port = serial_res.new()
var is_port_open = false 
signal azul
signal verde
signal amarelo
signal vermelho
signal cont
var msg = ""

func _ready():
	is_port_open = serial_port.open_port('COM6', 115200) #colocar a porta que o esp ta conectado pela opção tool no ide 
	print(is_port_open)


func _process(delta):
	if(is_port_open):
		var message = serial_port.read_text()
		if(message.length() > 0):
			for i in message:
				if(i == '\n'):
					print(msg)
					_text_interpreter(msg)
					msg = ''
				else:
					msg = msg + i


func _text_interpreter(msg):
	var command = msg.split(' ')
	if(command[0] == '1'): #Esse Direita é oq ta escrito no digital write no IDE
		emit_signal("azul")  
	if(command[0] == '2'):
		while(command[0] == '2'):
			emit_signal("verde")
			msg = serial_port.read_text()
			command = msg.split(' ')
	if(command[0] == '3'):
		emit_signal("amarelo") 
	if(command[0] == '4'):
		emit_signal("vermelho") 
	if(command[0] == '5'):
		emit_signal("cont") 
