extends Node

func _ready() -> void:
	for item in Items.items:
		var event_name = item["item_name"]
		var probability = item["probability"]
		var function = Callable(self, item["function"])
		var slug = item["slug"]
		ItemStates.items.append(Item.create(event_name, probability, function, slug))
		
	normalize_probabilities()
	
func normalize_probabilities() -> void:
	var total_probability = 0.0
	for item in ItemStates.items:
		total_probability += item.probability

	if total_probability == 0:
		return
		
	for item in ItemStates.items:
		item.probability /= total_probability

## These functions are where we would implement the actual logic for the items
	## armor for example could increment a defense property in the Player class
func draw_items():
	pass

func armor():
	print(PlayerStates.players[GameState.current_turn].name, " used armor")
	remove_used_item()
	
func empty():
	print(PlayerStates.players[GameState.current_turn].name, " used nothing")
	remove_used_item()
	
func remove_used_item():
	## Since only the active player can use an item, we can manually update their items array
		## and because the items are updated by the ui_handler in main.gd, we don't need to worry about the ui here
	var selected_index = PlayerStates.players[GameState.current_turn].selected_item_index
	PlayerStates.players[GameState.current_turn].items[selected_index] = "empty"
	selected_index = 0
