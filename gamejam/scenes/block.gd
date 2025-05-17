extends Node2D

var falling = false
var spawn:Vector2
var Watered = false

func _ready():
	spawn = position

func _process(delta: float) -> void:
	if falling == true:
		if !$RayCast2D.is_colliding():
			position.y+=10
		else:
			falling = false
	if Watered == true:
		if position.y > spawn.y:
			position.y-=20
			falling = false
		else:
			Watered = false

func fall():
	if !($Timer.time_left >0):
		$Timer.start()

func _on_timer_timeout() -> void:
	falling = true
