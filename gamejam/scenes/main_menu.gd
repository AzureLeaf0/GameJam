extends Control


@onready var start_button = $VBoxContainer/StartButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var quit_button = $VBoxContainer/QuitButton

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	credits_button.pressed.connect(_on_credits_pressed)  # varsa

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/map.tscn")  # Oyun sahnenin yolu

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	print("Options açılacak (henüz yapılmadı)") 
