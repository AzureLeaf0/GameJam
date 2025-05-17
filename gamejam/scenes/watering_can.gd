extends Node2D

var current = 0
var max = 3
var triggered = false
var currentPlant
@onready var wateringArea = $WaterArea

func use():
	if current > 0:
		if $WaterCan.flip_h == true:
			$AnimationPlayer.play("watering_left")
		else:
			$AnimationPlayer.play("watering_right")
		visible = true
		get_parent().WaterTimer.start()
		get_parent().is_watering = true
		current = current - 1
		if currentPlant != null:
			currentPlant.Watered = true
		
func refill():
	current = max

func _on_water_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Plant") or area.is_in_group("FallBlock"):
		triggered = true
		if area.is_in_group("Plant"):
			currentPlant = area
		else:
			currentPlant = area.get_parent()

func _on_water_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Plant") or area.is_in_group("FallBlock"):
		triggered = false
		currentPlant = null
