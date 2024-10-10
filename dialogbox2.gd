extends NinePatchRect

onready var text := $text
onready var timer := $Timer
var msg_queue: Array = [
	"Olá, jogador!" , 
	"Meu nome é Menno. sou um poderoso mago que precisa de sua ajuda!",
	"Meu mundo foi invadido por Chrollo, um feiticeiro do mal, e seu exército de inimigos!",
	"Nossa missão é coletar moedas, derrotar o feiticeiro maligno e seu exército, e superar desafios matemáticos ao longo do caminho.",
	"As perguntas de matemática são muito importantes.",
	"Se responder certo, ganho poderes legais, como correr mais rápido ou pular duas vezes! Mas se eu errar, perco uma vida. Só tenho quatro vidas para completar minha missão!",
	"Para vencer, precisamos ser inteligentes e ligeiros, assim vamos conseguir passar todos os desafios e perigos desse mundo mágico!"
]

func _input(event):
	if event is InputEventKey and event.is_action_pressed("ui_accept"):
		show_message()
		
func show_message() -> void: 
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()
		return 
		
	if msg_queue.size() == 0:
		hide()
		return
	
	var _msg : String = msg_queue.pop_front()
	text.visible_characters = 0
	text.bbcode_text = _msg
	timer.start()

func _on_Timer_timeout():
	if text.visible_characters == text.bbcode_text.length():
		timer.stop()
	text.visible_characters +=1
