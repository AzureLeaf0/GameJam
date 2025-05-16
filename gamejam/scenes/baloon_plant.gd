extends Area2D

var Collection = load("res://scenes/BaloonPlantItem.tscn")
var WateredVisual = load("res://Images/BaloonPlantCollect.png")
var ThirstyVisual = load("res://Images/BaloonPlantGone.png")
var Watered = true
@onready var Visual = $Sprite2D

func _process(delta) -> void:
	if Watered == true:
		Visual.texture = WateredVisual
	else:
		Visual.texture = ThirstyVisual
