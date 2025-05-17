extends Node

func play_music(count: int):
	if count == 0:
		$AudioStreamPlayer.play()
		$AudioStreamPlayer2.stop()
	if count == 1:
		$AudioStreamPlayer2.play()
		$AudioStreamPlayer.stop()
