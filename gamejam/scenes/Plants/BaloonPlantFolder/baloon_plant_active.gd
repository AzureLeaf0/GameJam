extends Node2D

var side
var t = 0.0
var follow

func _ready():
	$AudioStreamPlayer2D.play()

func _process(delta) -> void:
	if follow != null:
		position = follow.global_position

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		follow = area.get_parent()
