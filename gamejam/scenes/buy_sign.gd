extends Area2D

@export var Price:int
@export var Visual:Texture
@export var Buy:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = Price
	$Sprite2D.texture = Visual


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
