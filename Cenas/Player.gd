extends KinematicBody2D

export var gravity = 10
export var walk_speed = 120
export var jump_force = -250
export var velocity = Vector2()
export var can_double_jump = true
export var coins = 0

signal morreu

func _physics_process(delta):
	var mov_horizontal =  Input. get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = mov_horizontal * walk_speed 
	if is_on_floor():
		if abs(velocity.x)>0:
			$Animacao.play("walk")
		else:
			$Animacao.play("idle")
	else:
		$Animacao.play("jump")

	if velocity.x > 0:
		$Animacao.flip_h = false
	elif velocity.x < 0:
		$Animacao.flip_h = true
		
	
	if is_on_ceiling():
		velocity.y = 0
	if Global.checkpoint ==0:
		can_double_jump = false
	elif Global.checkpoint >= 1:
		if is_on_floor():
			can_double_jump = true
	if not is_on_floor():
		velocity.y += gravity 

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		
		velocity.y = jump_force
		$AudioPulo.play()

		
		
	elif can_double_jump and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
		can_double_jump = false
		$AudioPulo.play()

	move_and_slide(velocity, Vector2.UP)


func _on_Notificador_screen_exited():
	emit_signal("morreu")
	$AudioMorte.play()
	


func _on_Area2D_body_entered(body):
	if body.name == "Inimigo" || body.name == "Inimigo2" ||  body.name == "Lava" || body.name == "Inimigo3" || body.name == "Inimigo4" || body.name == "Inimigo5" || body.name == "Inimigo6" || body.name == "Inimigo7" || body.name == "Inimigo8" || body.name == "Inimigo9":
		
		if(Global.pontos-100 <= 0):
			Global.pontos = 0
		else:
			Global.pontos -=100
		emit_signal("morreu")
		$AudioMorteInimigo.play()


