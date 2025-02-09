extends Control


var winner: Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_winner()

<<<<<<< HEAD
func display_winner(winner):
	var players = PlayerStates.players
	var avatar_assets_path : String = "res://assets/pictures/"
	var resource_suffix : String = ".png"

	var message = "player " + players[winner].name
	$Winner.text = message
	
	var winner_image = load(avatar_assets_path + players[winner].job + resource_suffix)
=======
func display_winner():
	var message = "%s Wins" % winner.player_name
	#var message = "player " + winner.name
	$Winner.text = message
	
	var winner_image = load(AssetPaths.avatar_assets_path + winner.job + AssetPaths.resource_suffix)
>>>>>>> caae35b11f18c58dae4e76afd664c29e3e762936
	$TextureRect.texture = winner_image
	#$portrait_frame.texture = ImageTexture.create_from_image(winner_image)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _restart_game() -> void:
	get_tree().change_scene_to_file("res://scenes/titlepage.tscn")
