extends Node2D

var MenuLogo = load("res://Images/BaloonPlantRelease.png")
var spawn = load("res://scenes/Plants/BaloonPlantFolder/BaloonPlantActive.tscn")

func _on_timer_timeout() -> void:
	print("a")
