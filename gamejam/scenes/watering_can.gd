extends Node2D

var current = 3
var max = 3
@onready var wateringArea = $WaterArea

func use():
	if current > 0:
		visible = true
		wateringArea.monitorable = true
		get_parent().WaterTimer.start()
		get_parent().is_watering = true
		current = current - 1
		print("Kalan sulama hakkı: " + str(current))
	else:
		print("Sulama kabı boş.")
		
func refill():
	current = max
	print("Sulama kabı dolduruldu!")
