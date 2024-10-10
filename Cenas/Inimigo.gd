extends KinematicBody2D

var direcao = -1
var speed = 100
signal matou


func _physics_process(delta):
	translate(Vector2(speed*direcao*delta, 0))



func _on_TimerPatrulha_timeout():
	direcao *= -1
	if(direcao >= 0):
		$Animacao.flip_h = true
	else:
		$Animacao.flip_h = false

func _on_AreaImpacto_body_entered(body):
	if body.name== "Player":
		emit_signal("matou")
		queue_free()
