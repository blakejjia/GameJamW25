extends Node

@onready var game_interface = get_tree().current_scene.get_node("GameInterface")

func update_player_job(new_job: String, index: int) -> void:
	PlayerStates.players[index].ui.update_job(new_job)

func update_player_name(new_name: String, index: int) -> void:
	PlayerStates.players[index].ui.update_name(new_name)

func update_player_avatar(texture_path: String, index: int) -> void:
	PlayerStates.players[index].ui.update_avatar(texture_path)

func update_player_health(new_health: int, index: int) -> void:
	PlayerStates.players[index].ui.update_health(new_health)

func update_player_items(items: Array[String], index: int) -> void:
	PlayerStates.players[index].ui.set_item_list(items)

func update_turn_label() -> void:
	var current_player_name = PlayerStates.players[GameState.current_turn].player_name
	game_interface.update_turn(current_player_name + "'s" + " Turn")

func update_player_labels() -> void:
	for player in PlayerStates.players:
		update_player_health(player.health, player.id)
		update_player_items(player.items, player.id)
		
