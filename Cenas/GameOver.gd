extends Node2D
var pontosFinais = 0
func _on_GameOver_ready():
	$AudioStreamPlayer.play()
	pontosFinais = Global.pontos
	$Label.text = "Pontuacao final: " 
	$Label2.text = str(Global.pontos)
	Global.life = 4
	Global.checkpoint = 0


func _on_Button_pressed():
	Global.pontos = 0
	get_tree().change_scene("res://Cenas/Level.tscn")

func _on_Button2_pressed():
	get_tree().change_scene("res://Cenas/TelaInicial.tscn")

func _on_Button3_pressed():
	get_tree().quit()
