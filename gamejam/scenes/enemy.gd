extends RigidBody2D

var SPEED = 1800
var direction = 1
var touchedplayer

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var sprite: AnimatedSprite2D = $Sprite2D

func _ready():
	$AudioStreamPlayer2D.play()
	sprite.play("default")

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
	if area.is_in_group("Player"):
		touchedplayer = area
	if area.is_in_group("Sword"):
		if touchedplayer != null:
			touchedplayer.get_parent().touch_enemy = false
		$Area2D.remove_from_group("Enemy")
		sprite.play("Die")
		SPEED = 0
		$DeathTimer.start()
		$GPUParticles2D.emitting = true
			

func _on_death_timer_timeout() -> void:
	queue_free()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		touchedplayer = null
