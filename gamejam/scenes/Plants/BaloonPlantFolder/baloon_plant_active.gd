extends Node2D

var side

func _process(delta: float) -> void:
	position.y= position.y-5

func _on_timer_timeout() -> void:
	queue_free()
