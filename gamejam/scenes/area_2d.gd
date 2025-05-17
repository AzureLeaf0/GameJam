extends Area2D

@export var score_screen_path: NodePath  # Exported so you can set it in the editor

func _ready():
	# Optional: auto-assign the path if not already set
	if score_screen_path == NodePath(""):
		score_screen_path = "../ScoreUI"
	
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		var score_screen = get_node(score_screen_path)
		score_screen.visible = true
		body.set_physics_process(false)
