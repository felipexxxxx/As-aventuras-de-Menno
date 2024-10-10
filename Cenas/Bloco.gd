extends StaticBody2D

var life = 1
signal quebrou


func _on_AreaImpacto_body_entered(_body):
	life -= 1
	if life==0:
		emit_signal("quebrou")
		queue_free()
