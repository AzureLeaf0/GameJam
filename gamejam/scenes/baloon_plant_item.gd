extends Node2D

var MenuLogo = load("res://Images/BaloonPlantRelease.png")
var spawn = load("res://scenes/BaloonPlantActive.tscn")

func Use():
	var instance =spawn.instantiate()
