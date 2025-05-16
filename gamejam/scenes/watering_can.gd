extends Node2D

var current = 3
var max = 3

func use():
	if current > 0:
		current = current - 1
		print("Kalan sulama hakkı: " + current)
	else:
		print("Sulama kabı boş.")
		
func refill():
	current = max
	print("Sulama kabı dolduruldu!")
