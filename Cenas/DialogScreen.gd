extends Node2D



func _on_Button2_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Cenas/Level.tscn")


func _on_DialogScreen_ready():
	$AudioStreamPlayer.play()
	$Caixatexto/dialogbox2.show_message()
