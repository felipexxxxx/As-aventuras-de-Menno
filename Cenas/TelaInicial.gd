extends Node2D

func _ready():
	$AudioStreamPlayer.play()
	Serial.connect("azul", self, "_on_Button_pressed")
	Serial.connect("verde", self, "_on_Button2_pressed")
	Serial.connect("amarelo", self, "_on_Button3_pressed")


func _on_Button_pressed():
	get_tree().change_scene("res://Cenas/DialogScreen.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://Cenas/ControlScreen.tscn")

func _on_Button3_pressed():
	get_tree().quit()
