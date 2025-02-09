extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_winner(1)

func display_winner(winner):
	var message = "player %s" % str(winner)
	#var message = "player " + winner.name
	$Winner.text = message
	
	var winner_image = load("res://assets/pictures/doctor.png")
	#var winner_image = load(avatar_assets_path+winner.job+resource_suffix)
	$TextureRect.texture = ImageTexture.create_from_image(winner_image)
	#$portrait_frame.texture = ImageTexture.create_from_image(winner_image)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _restart_game() -> void:
	pass # Replace with function body.
