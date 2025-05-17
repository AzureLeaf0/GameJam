extends RigidBody2D

var SPEED = 1800
var direction = 1

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _process(delta: float) -> void:
	if direction == 0:
		position.x+=1*delta
	elif direction == 1:
		position.y+=1*delta
	elif direction == 2:
		position.x-=1*delta
	elif direction == 3:
		position.y-=1*delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		queue_free()


func _on_timer_timeout() -> void:
	randomize()
	direction = randi_range(0,3)
