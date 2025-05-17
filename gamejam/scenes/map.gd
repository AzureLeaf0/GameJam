extends Node2D

@onready var pause_menu: Control = $PauseMenu


func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused  # pause/toggle
		$PauseMenu.visible = get_tree().paused     # show pause menu when paused

func _on_resume_button_pressed():
	get_tree().paused = false
	$PauseMenu.visible = false

func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
