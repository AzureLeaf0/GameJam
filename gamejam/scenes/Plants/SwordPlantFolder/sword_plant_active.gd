extends Node2D

var side

func _ready():
	if side == true:
		rotation_degrees = -120
	else:
		rotation_degrees = 300

func _process(delta: float) -> void:
	if side == false:
		rotate(7*delta)
	else:
		rotate(-7*delta)

func _on_timer_timeout() -> void:
	queue_free()
