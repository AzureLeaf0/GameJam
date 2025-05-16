extends Node2D

enum blockType{
	Grass,
	Wood,
}

@export var visual: blockType
@onready var visualNode = $Sprite2D

func _ready() -> void:
	if visual == blockType.Grass:
		visualNode.texture = load("res://Images/GrassFloor.png")
	elif visual == blockType.Wood:
		visualNode.texture = load("res://Images/Wall.png")
