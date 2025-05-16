extends Area2D

var Collection = load("res://scenes/Plants/BaloonPlantFolder/BaloonPlantItem.tscn")
var WateredVisual = load("res://Images/Ruya/Bitki#2 balon toplanabilir.png")
var ThirstyVisual = load("res://Images/Ruya/Bitki#2 balon toplanamaz.png")
var rotTimer = 10
var Watered = true
@onready var Visual = $Sprite2D

func _process(delta) -> void:
	if Watered == true:
		Visual.texture = WateredVisual
	else:
		Visual.texture = ThirstyVisual
