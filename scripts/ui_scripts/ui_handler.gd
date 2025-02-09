extends Node

@onready var game_interface = get_tree().current_scene.get_node("GameInterface")
@onready var event_interface = get_tree().current_scene.get_node("EventInterface")

## Player related UI functions

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
		
## Event related UI functions

func show_event(event: Event):
	event_interface.update_name(event.event_name)
	var card_path = AssetPaths.event_cards_path + event.slug + AssetPaths.resource_suffix
	event_interface.update_card(card_path)


## Screens

func show_win_screen(winner: Player):
	print("Show win screen")
	
