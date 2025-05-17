extends Node2D

var falling = false

func _process(delta: float) -> void:
	if falling == true:
		if !$RayCast2D.is_colliding():
			position.y+=10

func fall():
	if !($Timer.time_left >0):
		$Timer.start()

func _on_timer_timeout() -> void:
	falling = true
