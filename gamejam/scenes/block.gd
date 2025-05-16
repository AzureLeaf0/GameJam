extends Node2D
@export var visual = load("res://Images/GrassFloor.png")
@onready var visualNode = $Sprite2D

func _ready() -> void:
	visualNode.texture = visual
