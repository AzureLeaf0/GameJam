extends Control


@onready var start_button = $VBoxContainer/HBoxContainer/StartButton
@onready var credits_button = $VBoxContainer/HBoxContainer/CreditsButton
@onready var quit_button = $VBoxContainer/HBoxContainer/QuitButton
@onready var settings_button = $SettingsButton


func _ready():
	AudioController.play_music()
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	settings_button.pressed.connect(_on_settings_pressed)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/map.tscn")  # Oyun sahnenin yolu

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	
func _on_settings_pressed():
	$OptionMenu.visible = !$OptionMenu.visible
