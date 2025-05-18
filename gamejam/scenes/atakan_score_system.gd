extends Node2D

var score:int
var maxscore:int = 3000
var deathcount:int
var teleportcount:int
var elapsed:int
var time_penalty = 0

func Called(adeathcount:int,ateleportcount:int,aelapsed:int):
	deathcount = adeathcount
	teleportcount = ateleportcount
	elapsed = aelapsed
	if elapsed > 180:
		time_penalty = elapsed-180
	score = maxscore - ((time_penalty*2)+(teleportcount*25)+(deathcount*100))
	if score < 0:
		score = 0
