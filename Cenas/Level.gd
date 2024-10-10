extends Node2D

var resposta1 = 0
var resposta2 = 0
var resposta3 = 0
var resposta4 = 0
var resposta5 = 0
var resposta6 = 0
var resposta7 = 0
var resposta8 = 0
var resposta9 = 0

func _on_Level_ready():
	$Lava/AnimatedSprite.play()
	$Lava/AnimatedSprite2.play()
	$Lava/AnimatedSprite3.play()
	$Lava/AnimatedSprite4.play()
	if(Global.checkpoint <= 1):
		Global.acertosPerguntas = 0
	if(Global.checkpoint == 1):
		$Player.position.x = 1729
		$Player.position.y = 226
		Global.acertosPerguntas = 3
	if(Global.checkpoint >= 2):
		$Player.position.x = 3387
		$Player.position.y = 290
		Global.acertosPerguntas = 6
	if(Global.checkpoint == 0):
		$Player.position.x = 300
		$Player.position.y = 250
	if(Global.audio):
		$AudioErrouPergunta.play()
	$AudioTema.play()
	atualizar_vida()
	$HUD/Pontos.text = str(Global.pontos)
	
	

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

	if (Global.life == 0):
		get_tree().change_scene("res://Cenas/GameOver.tscn")


func reinicia_posicao():
	if(Global.checkpoint == 1):
		$Player.position.x = 1729
		$Player.position.y = 226
	if(Global.checkpoint >= 2):
		$Player.position.x = 3387
		$Player.position.y = 290
	if(Global.checkpoint == 0):
		$Player.position.x = 300
		$Player.position.y = 250


func _on_Player_morreu():
	reinicia_posicao()
	Global.life-=1
	atualizar_vida()
	$HUD/Pontos.text = str(Global.pontos)
	

func _on_Moeda_pegou_moeda():
	$AudioMoeda.play()
	Global.pontos += 75
	$HUD/Pontos.text = str(Global.pontos)


func _on_Inimigo_matou():
	$AudioMatou.play()
	Global.pontos += 150
	$HUD/Pontos.text = str(Global.pontos)

	
func btn_acerto(a):
	$AudioAcertoPerguntas.play()
	Global.acertosPerguntas+=1
	$Player.walk_speed = 120 * 1.1
	$Player.jump_force = -250
	Global.pontos += 300
	$HUD/Pontos.text = str(Global.pontos)
	a.hide()
	if(Global.acertosPerguntas == 3):
		Global.checkpoint += 1
	if(Global.acertosPerguntas >= 6):
		$plataformamovel._start_tween()
		Global.checkpoint += 1
		
	Serial.connect("azul", self, "")
	Serial.connect("verde", self, "")
	Serial.connect("amarelo", self, "")
	Serial.connect("vermelho", self, "")
	
	if(Global.acertosPerguntas == 9):
		$AudioPortal.play()
		$Portal.show()

func btn_errado(a, b):
	$Player.walk_speed = 0
	$Player.jump_force = 0
	a.hide()
	Global.life -=1
	atualizar_vida()
	if(Global.pontos-225 <= 0):
		Global.pontos = 0
	else:
		Global.pontos -= 225
	Serial.connect("cont", self, "_on_continuar_pressed")
	b.show()
	Serial.connect("azul", self, "vazio")
	Serial.connect("verde", self, "vazio")
	Serial.connect("amarelo", self, "vazio")
	Serial.connect("vermelho", self, "vazio")
func vazio():
	var x= 0
func _on_continuar_pressed():
	if(Global.audio <=3):
		Global.audio +=1
	else:
		Global.audio =0
	$Player.walk_speed = 120 
	$Player.jump_force = -250
	Global.life+=1
	
	get_tree().change_scene("res://Cenas/Level.tscn")
	
	$TelaRespostaErrada.hide()
	
func _on_Lava_matou():
	$AudioLava.play()
	$Player.emit_signal("morreu")


func perguntas_aleatorias(resp1, certa, resp2, b, resp3, c, resp4, d):
	var resposta1 = 0
	var resposta2 = 0
	var resposta3 = 0
	while (resposta1 == resposta2 || resposta2 == resposta3 || resposta1 == resposta3):
		for i in (3) :
			resposta1 = randi() % 3
			resposta2 = randi() % 3
			resposta3 = randi() % 3
	resp1.text = str(certa)
	if(resposta1 == 0):
		resp2.text = str(b)
	if(resposta1 == 1):
		resp2.text = str(c)
	if(resposta1 == 2):
		resp2.text = str(d)
	
	if(resposta2 == 0):
		resp3.text = str(b)
	if(resposta2 == 1):
		resp3.text = str(c)
	if(resposta2 == 2):
		resp3.text = str(d)
	
	if(resposta3 == 0):
		resp4.text = str(b)
	if(resposta3 == 1):
		resp4.text = str(c)
	if(resposta3 == 2):
		resp4.text = str(d)
	
	
#PERGUNTA 1
func _on_Bloco_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta1.show()
	Serial.connect("azul", self, "_on_btn_certo1_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado1_1_pressed")
	Serial.connect("amarelo", self, "_on_btn_errado1_2_pressed")
	Serial.connect("vermelho", self, "_on_btn_errado1_3_pressed")
	#perguntas_aleatorias($Pergunta1/btn_certo1_1, "certa", $Pergunta1/btn_errado1_1, "abc", $Pergunta1/btn_errado1_2, "cde", $Pergunta1/btn_errado1_3, "fgh")
	
func _on_btn_certo1_1_pressed():
	if(resposta1 == 0):
		btn_acerto($Pergunta1)
		resposta1 += 1
	


func _on_btn_errado1_1_pressed():
	if(resposta1 == 0):
		
		btn_errado($Pergunta1, $TelaRespostaErrada)
		resposta1 += 1


func _on_btn_errado1_2_pressed():
	if(resposta1 == 0):
		btn_errado($Pergunta1, $TelaRespostaErrada)
		resposta1 += 1


func _on_btn_errado1_3_pressed():
	if(resposta1 == 0):
		btn_errado($Pergunta1, $TelaRespostaErrada)
		resposta1 += 1

#PERGUNTA2
func _on_Bloco2_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta2.show()
	Serial.connect("amarelo", self, "_on_btn_certo2_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado2_1_pressed")
	Serial.connect("azul", self, "_on_btn_errado2_2_pressed")
	Serial.connect("vermelho", self, "_on_btn_errado2_3_pressed")

func _on_btn_certo2_1_pressed():
	if(resposta2 == 0):
		btn_acerto($Pergunta2)
		resposta2 += 1

func _on_btn_errado2_1_pressed():
	if(resposta2 == 0):
		btn_errado($Pergunta2, $TelaRespostaErrada2)
		resposta2 += 1

func _on_btn_errado2_2_pressed():
	if(resposta2 == 0):
		btn_errado($Pergunta2, $TelaRespostaErrada2)
		resposta2 += 1

func _on_btn_errado2_3_pressed():
	if(resposta2 == 0):
		btn_errado($Pergunta2, $TelaRespostaErrada2)
		resposta2 += 1


#PERGUNTA 3
func _on_Bloco3_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta3.show()
	Serial.connect("vermelho", self, "_on_btn_certo3_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado3_1_pressed")
	Serial.connect("amarelo", self, "_on_btn_errado3_2_pressed")
	Serial.connect("azul", self, "_on_btn_errado3_3_pressed")

func _on_btn_certo3_1_pressed():
	if(resposta3 == 0):
		btn_acerto($Pergunta3)
		resposta3 += 1


func _on_btn_errado3_1_pressed():
	if(resposta3 == 0):
		btn_errado($Pergunta3, $TelaRespostaErrada3)
		resposta3 += 1

func _on_btn_errado3_2_pressed():
	if(resposta3 == 0):
		btn_errado($Pergunta3, $TelaRespostaErrada3)
		resposta3 += 1

func _on_btn_errado3_3_pressed():
	if(resposta3 == 0):
		btn_errado($Pergunta3, $TelaRespostaErrada3)
		resposta3 += 1


#PERGUNTA 4
func _on_Bloco4_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta4.show()
	Serial.connect("vermelho", self, "_on_btn_certo4_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado4_1_pressed")
	Serial.connect("amarelo", self, "_on_btn_errado4_2_pressed")
	Serial.connect("azul", self, "_on_btn_errado4_3_pressed")

func _on_btn_certo4_1_pressed():
	if(resposta4 == 0):
		btn_acerto($Pergunta4)
		resposta4 += 1

func _on_btn_errado4_1_pressed():
	if(resposta4 == 0):
		btn_errado($Pergunta4, $TelaRespostaErrada4)
		resposta4 += 1

func _on_btn_errado4_2_pressed():
	if(resposta4 == 0):
		btn_errado($Pergunta4, $TelaRespostaErrada4)
		resposta4 += 1

func _on_btn_errado4_3_pressed():
	if(resposta4 == 0):
		btn_errado($Pergunta4, $TelaRespostaErrada4)
		resposta4 += 1


#PERGUNTA 5
func _on_Bloco5_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta5.show()
	Serial.connect("amarelo", self, "_on_btn_certo5_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado5_1_pressed")
	Serial.connect("azul", self, "_on_btn_errado5_2_pressed")
	Serial.connect("vermelho", self, "_on_btn_errado5_3_pressed")

func _on_btn_certo5_1_pressed():
	if(resposta5 == 0):
		btn_acerto($Pergunta5)
		resposta5 += 1

func _on_btn_errado5_1_pressed():
	if(resposta5 == 0):
		btn_errado($Pergunta5, $TelaRespostaErrada5)
		resposta5 += 1

func _on_btn_errado5_2_pressed():
	if(resposta5 == 0):
		btn_errado($Pergunta5, $TelaRespostaErrada5)
		resposta5 += 1

func _on_btn_errado5_3_pressed():
	if(resposta5 == 0):
		btn_errado($Pergunta5, $TelaRespostaErrada5)
		resposta5 += 1


#PERGUNTA 6
func _on_Bloco6_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta6.show()
	Serial.connect("verde", self, "_on_btn_certo6_1_pressed")
	Serial.connect("azul", self, "_on_btn_errado6_1_pressed")
	Serial.connect("amarelo", self, "_on_btn_errado6_2_pressed")
	Serial.connect("vermelho", self, "_on_btn_errado6_3_pressed")

func _on_btn_certo6_1_pressed():
	if(resposta6 == 0):
		btn_acerto($Pergunta6)
		resposta6 += 1

func _on_btn_errado6_1_pressed():
	if(resposta6 == 0):
		btn_errado($Pergunta6, $TelaRespostaErrada6)
		resposta6 += 1

func _on_btn_errado6_2_pressed():
	if(resposta6 == 0):
		btn_errado($Pergunta6, $TelaRespostaErrada6)
		resposta6 += 1

func _on_btn_errado6_3_pressed():
	if(resposta6 == 0):
		btn_errado($Pergunta6, $TelaRespostaErrada6)
		resposta6 += 1


#PERGUNTA 7
func _on_Bloco7_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta7.show()
	Serial.connect("vermelho", self, "_on_btn_certo7_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado7_1_pressed")
	Serial.connect("amarelo", self, "_on_btn_errado7_2_pressed")
	Serial.connect("azul", self, "_on_btn_errado7_3_pressed")

func _on_btn_certo7_1_pressed():
	if(resposta7 == 0):
		btn_acerto($Pergunta7)
		resposta7 += 1

func _on_btn_errado7_1_pressed():
	if(resposta7 == 0):
		btn_errado($Pergunta7, $TelaRespostaErrada7)
		resposta7 += 1

func _on_btn_errado7_2_pressed():
	if(resposta7 == 0):
		btn_errado($Pergunta7, $TelaRespostaErrada7)
		resposta7 += 1

func _on_btn_errado7_3_pressed():
	if(resposta7 == 0):
		btn_errado($Pergunta7, $TelaRespostaErrada7)
		resposta7 += 1


#PERGUNTA 8
func _on_Bloco8_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta8.show()
	Serial.connect("vermelho", self, "_on_btn_certo8_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado8_1_pressed")
	Serial.connect("amarelo", self, "_on_btn_errado8_2_pressed")
	Serial.connect("azul", self, "_on_btn_errado8_3_pressed")

func _on_btn_certo8_1_pressed():
	if(resposta8 == 0):
		btn_acerto($Pergunta8)
		resposta8 += 1

func _on_btn_errado8_1_pressed():
	if(resposta8 == 0):
		btn_errado($Pergunta8, $TelaRespostaErrada8)
		resposta8 += 1

func _on_btn_errado8_2_pressed():
	if(resposta8 == 0):
		btn_errado($Pergunta8, $TelaRespostaErrada8)
		resposta8 += 1

func _on_btn_errado8_3_pressed():
	if(resposta8 == 0):
		btn_errado($Pergunta8, $TelaRespostaErrada8)
		resposta8 += 1


#PERGUNTA 9
func _on_Bloco9_quebrou():
	$AudioQuebrouBloco.play()
	Global.perguntas +=1
	$Player.walk_speed = 0
	$Player.jump_force = 0
	$Pergunta9.show()
	Serial.connect("azul", self, "_on_btn_certo9_1_pressed")
	Serial.connect("verde", self, "_on_btn_errado9_1_pressed")
	Serial.connect("amarelo", self, "_on_btn_errado9_2_pressed")
	Serial.connect("vermelho", self, "_on_btn_errado9_3_pressed")

func _on_btn_certo9_1_pressed():
	if(resposta9 == 0):
		btn_acerto($Pergunta9)
		resposta9 += 1

func _on_btn_errado9_1_pressed():
	if(resposta9 == 0):
		btn_errado($Pergunta9, $TelaRespostaErrada9)
		resposta9 += 1

func _on_btn_errado9_2_pressed():
	if(resposta9 == 0):
		btn_errado($Pergunta9, $TelaRespostaErrada9)
		resposta9 += 1

func _on_btn_errado9_3_pressed():
	if(resposta9 == 0):
		btn_errado($Pergunta9, $TelaRespostaErrada9)
		resposta9 += 1


func _on_Portal_body_entered(body):
	if(Global.acertosPerguntas == 9):
		Global.life = Global.life + 1
		get_tree().change_scene("res://Cenas/Boss.tscn")
