extends Node2D

var SPEED = 60

var direction = 1

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1	
		sprite.flip_h = false
		
	position.x += direction * SPEED * delta

	
