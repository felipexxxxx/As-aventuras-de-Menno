extends StaticBody2D


signal matou

func _on_Area2D_body_entered(body):
	if body.name == "Player" :
		emit_signal("matou")
