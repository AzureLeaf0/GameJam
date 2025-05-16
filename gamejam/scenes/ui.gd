extends Control

@onready var CoinDisplay = $CanvasLayer/CoinDisplay
@onready var Invent = [$CanvasLayer/GridContainer2/TextureRect, $CanvasLayer/GridContainer2/TextureRect2,$CanvasLayer/GridContainer2/TextureRect3,$CanvasLayer/GridContainer2/TextureRect4, $CanvasLayer/GridContainer2/TextureRect5,]

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	CoinDisplay.text = str(get_parent().coin)
	for i in range(1, get_parent().InventoryCapacity):
		if get_parent().Inventory[i] != null:
			Invent[i].texture = get_parent().Inventory[i].MenuLogo
