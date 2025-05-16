extends RigidBody2D

var side
var prepared = false

func _process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		prepared = true

func _on_timer_timeout() -> void:
	queue_free()
