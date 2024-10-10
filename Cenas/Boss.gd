extends Node2D

var bosslife = 4
var respostas = 0
func _ready():
	$HUD/Pontos.text = str(Global.pontos)
	$AudioTemaBoss.play()
	Global.life = 4

	
	atualizar_vida()
	if(respostas == 0):
		Serial.connect("azul", self, "_on_certo1_pressed")
		Serial.connect("verde", self, "_on_errado1_1_pressed")
		Serial.connect("amarelo", self, "_on_errado1_2_pressed")
		Serial.connect("vermelho", self, "_on_errado1_3_pressed")

func atualizar_vida():
	if Global.life == 4:
		$HUD/vidaperdida1.hide()
		$HUD/vidaperdida2.hide()
		$HUD/vidaperdida3.hide()
		$HUD/vidaperdida4.hide()
		
	if Global.life == 3:

		$HUD/vidaperdida1.hide()
		$HUD/vidaperdida2.hide()
		$HUD/vidaperdida3.hide()
		$HUD/vida4.hide()
		$HUD/vidaperdida4.show()
		
	if Global.life == 2:

		$HUD/vidaperdida1.hide()
		$HUD/vidaperdida2.hide()
		$HUD/vida3.hide()
		$HUD/vidaperdida3.show()
		$HUD/vida4.hide()
		$HUD/vidaperdida4.show()
		
	if Global.life == 1:

		$HUD/vidaperdida1.hide()
		$HUD/vida2.hide()
		$HUD/vidaperdida2.show()
		$HUD/vida3.hide()
		$HUD/vidaperdida3.show()
		$HUD/vida4.hide()
		$HUD/vidaperdida4.show()
	
	if(bosslife == 4):

		$VidaVazia4.hide()
		$VidaVazia3.hide()
		$VidaVazia2.hide()
		$VidaVazia1.hide()
	if(bosslife == 3):

		$VidaVazia4.show()
		$VidaVazia3.hide()
		$VidaVazia2.hide()
		$VidaVazia1.hide()
	if(bosslife == 2):

		$VidaVazia4.show()
		$VidaVazia3.show()
		$VidaVazia2.hide()
		$VidaVazia1.hide()
	if(bosslife == 1):

		$VidaVazia4.show()
		$VidaVazia3.show()
		$VidaVazia2.show()
		$VidaVazia1.hide()
		
	if (Global.life == 0):
		get_tree().change_scene("res://Cenas/GameOver.tscn")
	if (bosslife ==0):
		get_tree().change_scene("res://Cenas/TelaVitoria.tscn")



func atualizar_btn(cor1, cor2, cor3, cor4, a, b, c, d):
	Serial.connect(cor1, self, a)
	Serial.connect(cor2, self, b)
	Serial.connect(cor3, self, c)
	Serial.connect(cor4, self, d)

func btn_certo(a, b):
	$AudioAcertoPerguntasBoss.play()
	a.hide()
	bosslife -= 1
	respostas +=1
	Global.pontos += 500
	$HUD/Pontos.text = str(Global.pontos)
	atualizar_vida()
	b.show()
	
func btn_errado(a, b):
	$AudioErradoPerguntaBoss.play()
	a.hide()
	Global.life -=1
	if(Global.pontos-350 <= 0):
		Global.pontos = 0
	else:
		Global.pontos -= 350
	respostas+=1
	$HUD/Pontos.text = str(Global.pontos)
	atualizar_vida()
	b.show()


func _on_certo1_pressed():
	if(respostas == 0):
		btn_certo($Pergunta1, $Pergunta2)
		atualizar_btn("amarelo", "verde", "azul", "vermelho", "_on_errado2_2_pressed", "_on_errado2_1_pressed","_on_errado2_3_pressed",  "_on_certo2_pressed")

func _on_errado1_1_pressed():
	if(respostas == 0):
		btn_errado($Pergunta1, $Pergunta2)
		atualizar_btn("amarelo", "verde", "azul", "vermelho", "_on_errado2_2_pressed", "_on_errado2_1_pressed","_on_errado2_3_pressed",  "_on_certo2_pressed")

func _on_errado1_2_pressed():
	if(respostas == 0):
		btn_errado($Pergunta1, $Pergunta2)
		atualizar_btn("amarelo", "verde", "azul", "vermelho", "_on_errado2_2_pressed", "_on_errado2_1_pressed","_on_errado2_3_pressed",  "_on_certo2_pressed")

func _on_errado1_3_pressed():
	if(respostas == 0):
		btn_errado($Pergunta1, $Pergunta2)
		atualizar_btn("amarelo", "verde", "azul", "vermelho", "_on_errado2_2_pressed", "_on_errado2_1_pressed","_on_errado2_3_pressed",  "_on_certo2_pressed")

func _on_certo2_pressed():
	if(respostas == 1):
		btn_certo($Pergunta2, $Pergunta3)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado3_3_pressed", "_on_errado3_1_pressed","_on_errado3_2_pressed",  "_on_certo3_pressed")

func _on_errado2_1_pressed():
	if(respostas == 1):
		btn_errado($Pergunta2, $Pergunta3)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado3_3_pressed", "_on_errado3_1_pressed","_on_errado3_2_pressed",  "_on_certo3_pressed")

func _on_errado2_2_pressed():
	if(respostas == 1):
		btn_errado($Pergunta2, $Pergunta3)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado3_3_pressed", "_on_errado3_1_pressed","_on_errado3_2_pressed",  "_on_certo3_pressed")
		

func _on_errado2_3_pressed():
	if(respostas == 1):
		btn_errado($Pergunta2, $Pergunta3)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado3_3_pressed", "_on_errado3_1_pressed","_on_errado3_2_pressed",  "_on_certo3_pressed")


func _on_certo3_pressed():
	if(respostas == 2):
		btn_certo($Pergunta3, $Pergunta4)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado4_1_pressed", "_on_errado4_2_pressed","_on_certo4_pressed",  "_on_errado4_3_pressed")

func _on_errado3_1_pressed():
	if(respostas == 2):
		btn_errado($Pergunta3, $Pergunta4)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado4_1_pressed", "_on_errado4_2_pressed","_on_certo4_pressed",  "_on_errado4_3_pressed")

func _on_errado3_2_pressed():
	if(respostas == 2):
		btn_errado($Pergunta3, $Pergunta4)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado4_1_pressed", "_on_errado4_2_pressed","_on_certo4_pressed",  "_on_errado4_3_pressed")

func _on_errado3_3_pressed():
	if(respostas == 2):
		btn_errado($Pergunta3, $Pergunta4)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado4_1_pressed", "_on_errado4_2_pressed","_on_certo4_pressed",  "_on_errado4_3_pressed")

func _on_errado4_1_pressed():
	if(respostas == 3):
		btn_errado($Pergunta4, $Pergunta5)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado5_1_pressed", "_on_certo5_pressed","_on_errado5_2_pressed",  "_on_errado5_3_pressed")

func _on_errado4_2_pressed():
	if(respostas == 3):
		btn_errado($Pergunta4, $Pergunta5)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado5_1_pressed", "_on_certo5_pressed","_on_errado5_2_pressed",  "_on_errado5_3_pressed")
func _on_certo4_pressed():
	if(respostas == 3):
		btn_certo($Pergunta4, $Pergunta5)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado5_1_pressed", "_on_certo5_pressed","_on_errado5_2_pressed",  "_on_errado5_3_pressed")
func _on_errado4_3_pressed():
	if(respostas == 3):
		btn_errado($Pergunta4, $Pergunta5)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado5_1_pressed", "_on_certo5_pressed","_on_errado5_2_pressed",  "_on_errado5_3_pressed")



func _on_errado5_1_pressed():
	if(respostas == 4):
		btn_errado($Pergunta5, $Pergunta6)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_certo6_pressed", "_on_errado6_1_pressed","_on_errado6_2_pressed",  "_on_errado6_3_pressed")

func _on_certo5_pressed():
	if(respostas == 4):
		btn_certo($Pergunta5, $Pergunta6)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_certo6_pressed", "_on_errado6_1_pressed","_on_errado6_2_pressed",  "_on_errado6_3_pressed")

func _on_errado5_2_pressed():
	if(respostas == 4):
		btn_errado($Pergunta5, $Pergunta6)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_certo6_pressed", "_on_errado6_1_pressed","_on_errado6_2_pressed",  "_on_errado6_3_pressed")


func _on_errado5_3_pressed():
	if(respostas == 4):
		btn_errado($Pergunta5, $Pergunta6)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_certo6_pressed", "_on_errado6_1_pressed","_on_errado6_2_pressed",  "_on_errado6_3_pressed")


func _on_certo6_pressed():
	if(respostas == 5):
		btn_certo($Pergunta6, $Pergunta7)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado7_1_pressed", "_on_certo7_pressed","_on_errado7_2_pressed",  "_on_errado7_3_pressed")


func _on_errado6_1_pressed():
	if(respostas == 5):
		btn_errado($Pergunta6, $Pergunta7)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado7_1_pressed", "_on_certo7_pressed","_on_errado7_2_pressed",  "_on_errado7_3_pressed")
		

func _on_errado6_3_pressed():
	if(respostas == 5):
		btn_errado($Pergunta6, $Pergunta7)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado7_1_pressed", "_on_certo7_pressed","_on_errado7_2_pressed",  "_on_errado7_3_pressed")


func _on_errado6_2_pressed():
	if(respostas == 5):
		btn_errado($Pergunta6, $Pergunta7)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado7_1_pressed", "_on_certo7_pressed","_on_errado7_2_pressed",  "_on_errado7_3_pressed")
		

func _on_errado7_1_pressed():
	if(respostas == 6):
		btn_errado($Pergunta7, $Pergunta8)
		atualizar_btn("azul", "verde", "amarelo", "vermelho", "_on_errado8_1_pressed", "_on_errado8_2_pressed","_on_certo8_pressed",  "_on_errado8_3_pressed")
		

func _on_certo7_pressed():
	if(respostas == 6):
		btn_certo($Pergunta7, $Pergunta8)

func _on_errado7_2_pressed():
	if(respostas == 6):
		btn_errado($Pergunta7, $Pergunta8)

func _on_errado7_3_pressed():
	if(respostas == 6):
		btn_errado($Pergunta7, $Pergunta8)


func _on_errado8_1_pressed():
	get_tree().change_scene("res://Cenas/GameOver.tscn")


func _on_errado8_2_pressed():
	get_tree().change_scene("res://Cenas/GameOver.tscn")
func _on_certo8_pressed():
	get_tree().change_scene("res://Cenas/TelaVitoria.tscn")

func _on_errado8_3_pressed():
	get_tree().change_scene("res://Cenas/GameOver.tscn")
