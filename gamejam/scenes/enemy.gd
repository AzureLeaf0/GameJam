extends RigidBody2D

var SPEED = 1800
var direction = 1

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		var collider = ray_cast_right.get_collider()
		if not collider.is_in_group("Player"):
			direction = -1
			sprite.flip_h = true

	if ray_cast_left.is_colliding():
		var collider = ray_cast_left.get_collider()
		if not collider.is_in_group("Player"):
			direction = 1
			sprite.flip_h = false

	position.x += direction * SPEED * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		queue_free()
