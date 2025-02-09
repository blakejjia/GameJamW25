extends Button

@onready var item_functions = get_node("ItemFunctions")

func _ready() -> void:
	connect("pressed", _on_button_pressed)

func _on_button_pressed() -> void:
	var current_player = PlayerStates.players[GameState.current_turn]
	item_functions.call(current_player.selected_item)
	
