extends RigidBody2D

var SPEED = 1800
var direction = 0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _ready():
	sprite_2d.play("default")

func _process(delta: float) -> void:
	if direction == 0:
		position.x+=10
		sprite_2d.flip_h = false
	elif direction == 1:
		position.x+=6
		position.y+=6
		sprite_2d.flip_h = false
	elif direction == 2:
		position.y+=10
	elif direction == 3:
		position.x-=6
		position.y+=6
		sprite_2d.flip_h = true
	elif direction == 4:
		position.x-=10
		sprite_2d.flip_h = true
	elif direction == 5:
		position.x-=6
		position.y-=6
		sprite_2d.flip_h = true
	elif direction == 6:
		position.y-=10
	elif direction == 7:
		position.x+=6
		position.y-=6
		sprite_2d.flip_h = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		queue_free()


func _on_timer_timeout() -> void:
	direction = randi_range(0,7)
