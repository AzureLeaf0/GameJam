extends Node2D

var current = 0
var max = 3
var triggered = false
var currentPlant
@onready var wateringArea = $WaterArea

@onready var drop_1: TextureRect = $Ui/CanvasLayer/GridContainer5/Drop1
@onready var drop_2: TextureRect = $Ui/CanvasLayer/GridContainer5/Drop2
@onready var drop_3: TextureRect = $/CanvasLayer/GridContainer5/Drop3


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
	if area.is_in_group("Plant"):
		triggered = true
		currentPlant = area

func _on_water_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Plant"):
		triggered = false
		currentPlant = null
