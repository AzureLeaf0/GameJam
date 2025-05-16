extends Control

@onready var CoinDisplay = $CanvasLayer/CoinDisplay
@onready var Invent = [$CanvasLayer/GridContainer2/TextureRect, $CanvasLayer/GridContainer2/TextureRect2,$CanvasLayer/GridContainer2/TextureRect3,$CanvasLayer/GridContainer2/TextureRect4, $CanvasLayer/GridContainer2/TextureRect5,]

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	CoinDisplay.text = str(get_parent().coin)
	for i in range(0, get_parent().InventoryCapacity):
		if get_parent().Inventory[i] != null:
			var a = get_parent().Inventory[i].instantiate()
			Invent[i].texture = a.MenuLogo
		else:
			Invent[i].texture = load("res://Images/EmptyTab.png")
