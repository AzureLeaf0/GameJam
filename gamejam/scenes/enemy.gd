extends Node2D

var SPEED = 60

var direction = 1

func _process(delta: float) -> void:
	position.x += direction * SPEED * delta
	



	
