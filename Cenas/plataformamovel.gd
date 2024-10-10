extends Node2D
onready var plataform = $plataform
onready var tween = $Tween


export var speed = 3.0
export var horizontal = true
export var distance = 140

const wait_durantion = 1

var follow = Vector2.ZERO


func _start_tween():
	var move_direction = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance 
	var duration = move_direction.length()/float(speed*16)
	tween.interpolate_property(
		plataform ,"position" , Vector2.ZERO, move_direction,duration ,
		 Tween.TRANS_LINEAR,Tween.EASE_IN_OUT , wait_durantion
	)
	tween.interpolate_property(
		plataform ,"position" , move_direction, Vector2.ZERO ,duration ,
		 Tween.TRANS_LINEAR,Tween.EASE_IN_OUT , duration+ wait_durantion*2
	)
	tween.start()

