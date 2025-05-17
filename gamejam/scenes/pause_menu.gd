extends Control

var _is_paused:bool = false:
	set = set_paused

@onready var option_menu: Control = $OptionMenu
@onready var settings_button: TextureButton = $SettingsButton

func _ready():
	settings_button.pressed.connect(_on_settings_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self._is_paused = !_is_paused


func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	
func _on_resume_pressed() -> void:
	set_paused(false)

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_options_pressed() -> void:
	$OptionMenu.visible = !$OptionMenu.visible
	

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed():
	$OptionMenu.visible = !$OptionMenu.visible
	
