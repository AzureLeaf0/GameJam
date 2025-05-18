extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		AtakanScoreSystem.Called(area.get_parent().death_count,area.get_parent().teleport_count,area.get_parent().UIElement.elapsed_time)
		$CanvasLayer.visible = true
		var minutes = AtakanScoreSystem.elapsed / 60
		var seconds = AtakanScoreSystem.elapsed % 60
		$CanvasLayer/GridContainer/Label.text = "Congrats! You have finished with %s points out of 3000 points!" %AtakanScoreSystem.score

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed():
	$OptionMenu.visible = !$OptionMenu.visible
	


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.
