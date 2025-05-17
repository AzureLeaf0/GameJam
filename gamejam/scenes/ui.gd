extends Control

@onready var CoinDisplay = $CanvasLayer/CoinDisplay
@onready var Invent = [$CanvasLayer/GridContainer2/TextureRect, $CanvasLayer/GridContainer2/TextureRect2,$CanvasLayer/GridContainer2/TextureRect3]
@onready var InventActive = [$CanvasLayer/GridContainer/TextureRect,$CanvasLayer/GridContainer/TextureRect2,$CanvasLayer/GridContainer/TextureRect3]

@onready var game_timer: Timer = $CanvasLayer/UITimer
@onready var timer_label: Label = $CanvasLayer/TimerLabel

var elapsed_time := 0

func _ready():
	game_timer.wait_time = 1.0  # Her saniye artacak
	game_timer.autostart = true
	game_timer.one_shot = false
	game_timer.start()
	game_timer.timeout.connect(_on_game_timer_timeout)
	update_timer_label()
	
func _on_game_timer_timeout():
	elapsed_time += 1
	update_timer_label()
	
func update_timer_label():
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _process(delta: float) -> void:
	CoinDisplay.text = str(get_parent().coin)
	for i in range(0, get_parent().InventoryCapacity):
		if get_parent().Inventory[i] != null:
			var a = get_parent().Inventory[i].instantiate()
			Invent[i].texture = a.MenuLogo
		else:
			Invent[i].texture = load("res://Images/EmptyTab.png")
		if get_parent().current_inv == i:
			InventActive[i].texture = load("res://Images/InventoryTabActive.png")
		else:
			InventActive[i].texture = load("res://Images/InventoryTab.png")
	$CanvasLayer/GridContainer4/ProgressBar.max_value = get_parent().Item1T.wait_time
	$CanvasLayer/GridContainer4/ProgressBar.value = get_parent().Item1T.wait_time - get_parent().Item1T.time_left
	$CanvasLayer/GridContainer4/ProgressBar2.max_value = get_parent().Item2T.wait_time
	$CanvasLayer/GridContainer4/ProgressBar2.value = get_parent().Item2T.wait_time - get_parent().Item2T.time_left
	$CanvasLayer/GridContainer4/ProgressBar3.max_value = get_parent().Item3T.wait_time
	$CanvasLayer/GridContainer4/ProgressBar3.value = get_parent().Item3T.wait_time - get_parent().Item3T.time_left
