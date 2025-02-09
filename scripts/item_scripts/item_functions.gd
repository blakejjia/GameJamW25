extends Node

signal player_updated  
signal board_updated

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

## Separate function because it would probably have more complex logic
func zombie_killed(x, y):
	print("Zombie killed by ", PlayerStates.players[GameState.current_turn].player_name)
	BoardState.grid[x][y] = -1 ## Reset zombie's position to empty
	board_updated.emit()

## These functions are where we would implement the actual logic for the items
	## armor for example could increment a defense property in the Player class
func draw_items():
	pass

func armor():
	print(PlayerStates.players[GameState.current_turn].name, " used armor")
	remove_used_item()

func knife():
	print(PlayerStates.players[GameState.current_turn].name, " used knife")
	var grid = BoardState.grid
	
	# Define the directions to check (right, left, up, down)
	var directions = [
		Vector2i(1, 0),   # right
		Vector2i(-1, 0),  # left
		Vector2i(0, 1),   # down
		Vector2i(0, -1)   # up    
	]
	var x = PlayerStates.players[GameState.current_turn].player_x
	var y = PlayerStates.players[GameState.current_turn].player_y
	
	for dir in directions:
		var check_x = x + dir.x
		var check_y = y + dir.y
		# Make sure we're within grid bounds
		if check_x >= 0 and check_x < grid.size() and check_y >= 0 and check_y < grid[0].size():
			var grid_value = grid[check_x][check_y]
			if grid_value > -1 and grid_value != 4: ## Not a zombie, not an empty tile, not an event tile
				## Must be a player
				PlayerStates.players[grid_value].health -= 2
				player_updated.emit()
			elif grid_value == 4:
				zombie_killed(check_x, check_y)
				
	remove_used_item()
	
func empty():
	print(PlayerStates.players[GameState.current_turn].name, " used nothing")
	remove_used_item()

func remove_used_item():
	## Since only the active player can use an item, we can manually update their items array
	var selected_index = PlayerStates.players[GameState.current_turn].selected_item_index
	PlayerStates.players[GameState.current_turn].items[selected_index] = "empty"
	selected_index = 0
	
	## Send a signal to update the UI in main
	player_updated.emit()
