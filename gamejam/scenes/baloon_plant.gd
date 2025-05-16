extends Area2D

var Collection = load("res://scenes/BaloonPlantItem.tscn")
var WateredVisual = load("res://Images/Ruya/Bitki#2 balon.png")
var ThirstyVisual = load("res://Images/BaloonPlantGone.png")
var Watered = true
@onready var Visual = $Sprite2D

func _process(delta) -> void:
	if Watered == true:
		Visual.texture = WateredVisual
	else:
		Visual.texture = ThirstyVisual

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Water"):
		Watered == true
