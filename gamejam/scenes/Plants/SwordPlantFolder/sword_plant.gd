extends Area2D

var Collection = load("res://scenes/Plants/SwordPlantFolder/SwordPlantItem.tscn")
var WateredVisual = load("res://Images/Ruya/Bitki #3 sword toplanabilir.png")
var ThirstyVisual = load("res://Images/Ruya/Bitki #3 sword toplanamaz.png")
var rotTimer = 10
@export var Watered = true
@onready var Visual = $Sprite2D

func _process(delta) -> void:
	if Watered == true:
		Visual.texture = WateredVisual
	else:
		Visual.texture = ThirstyVisual
