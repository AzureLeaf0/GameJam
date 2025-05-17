extends Control

const MAX_SCORE = 1000
const TIME_PENALTY_PER_SECOND = 2
const TELEPORT_PENALTY = 25
const DEATH_PENALTY = 100

@onready var player = $"../player"
@onready var score_label = $ScoreLabel

func calculate_score(elapsed_time: float) -> int:
	var time_penalty = elapsed_time * TIME_PENALTY_PER_SECOND
	var teleport_penalty = player.teleport_count * TELEPORT_PENALTY
	var death_penalty = player.death_count * DEATH_PENALTY
	var raw_score = MAX_SCORE - (time_penalty + teleport_penalty + death_penalty)
	return max(0, raw_score)

func update_score(elapsed_time: float):
	var score = calculate_score(elapsed_time)
	score_label.text = "Score: " + str(score) + " / " + str(MAX_SCORE)
