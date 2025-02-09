extends Node

func _ready() -> void:
	for event in Events.events:
		var event_name = event["event_name"]
		var probability = event["probability"]
		var function = Callable(self, event["function"])
		var slug = event["slug"]
		EventsState.events.append(Event.create(event_name, probability, function, slug))
				
	# Normalize probabilities to ensure they sum to 1
	normalize_probabilities()

func normalize_probabilities() -> void:
	var total_probability = 0.0
	for event in EventsState.events:
		total_probability += event.probability

	if total_probability == 0:
		return
		
	for event in EventsState.events:
		event.probability /= total_probability
		
func get_random_empty_position_near(grid: Array, start_x: int, start_y: int, initial_radius: int = 1) -> Vector2i:
	var grid_width = grid.size()
	var grid_height = grid[0].size()
	var max_radius = max(grid_width, grid_height) # Maximum possible radius
	
	# Start from initial radius and expand outward
	for radius in range(initial_radius, max_radius + 1):
		var positions_at_radius: Array[Vector2i] = []
		
		# Check all positions at current radius
		for dx in range(-radius, radius + 1):
			for dy in range(-radius, radius + 1):
				# Only check positions exactly at current radius (creates a ring)
				if abs(dx) == radius or abs(dy) == radius:
					var x = start_x + dx
					var y = start_y + dy
					
					# Check if position is within grid bounds
					if x >= 0 and x < grid_width and y >= 0 and y < grid_height:
						# Check if position is empty (not containing a player 0-3)
						if grid[x][y] < 0 or grid[x][y] > 3:
							positions_at_radius.append(Vector2i(x, y))
		
			# If we found valid positions at this radius, return a random one
		if not positions_at_radius.is_empty():
			var random_index = randi() % positions_at_radius.size()
			return positions_at_radius[random_index]
	
	# If no position found at any radius, return invalid position
	return Vector2i(-1, -1)

## Event functions
func zombie_encounter(player_index):
	var player_x = PlayerStates.players[player_index].player_x
	var player_y = PlayerStates.players[player_index].player_y
	var spawn_position = get_random_empty_position_near(BoardState.grid, player_x, player_y)
	if spawn_position.x != -1 and spawn_position.y != -1:
		BoardState.grid[spawn_position.x][spawn_position.y] = 4 ## 4 corresponds to zombie
	else:
		## This should show a custom event card but it is pretty much impossible to ever happen
		print("Nothing happened")

## Called at the end of a turn in main.gd, which is probably not ideal
## Checks if the current player has moved adjacent to a zombie and if so, they will take 1 damage
func check_zombie_damage(turn: int):
	var grid = BoardState.grid
	
	# Define the directions to check (right, left, up, down)
	var directions = [
		Vector2i(1, 0), # right
		Vector2i(-1, 0), # left
		Vector2i(0, 1), # down
		Vector2i(0, -1) # up
	]
	
	for x in grid.size():
		for y in grid[x].size():
			# Skip if not a zombie
			if grid[x][y] != 4:
				continue
				
			# Check all adjacent tiles
			for dir in directions:
				var check_x = x + dir.x
				var check_y = y + dir.y
				# Make sure we're within grid bounds
				if check_x >= 0 and check_x < grid.size() and check_y >= 0 and check_y < grid[0].size():
					# Check if adjacent tile contains the player whose turn it is
					if grid[check_x][check_y] == turn:
						# Deal damage to the player
						PlayerStates.players[turn].health -= 1
						
## Event function for item farming
func new_item(player_index):
	var random_value = randf() # Random float between 0 and 1
	var cumulative_probability = 0.0
	for item in ItemStates.items:
		cumulative_probability += item.probability
		if random_value <= cumulative_probability:
			for i in range(PlayerStates.players[GameState.current_turn].items.size()):
				var player_item = PlayerStates.players[GameState.current_turn].items[i]
				if player_item == "empty":
					PlayerStates.players[GameState.current_turn].items[i] = item.item_name
					print("added: ", item.item_name)
					return
					
func lost(player_index):
	var player_x = PlayerStates.players[player_index].player_x
	var player_y = PlayerStates.players[player_index].player_y
	var new_position = get_random_empty_position_near(BoardState.grid, player_x, player_y)
	if new_position.x != -1 and new_position.y != -1:
		BoardState.grid[player_x][player_y] = -1
		PlayerStates.players[player_index].player_x = new_position.x
		PlayerStates.players[player_index].player_y = new_position.y
		BoardState.grid[new_position.x][new_position.y] = player_index

		print("set the grid state of ", player_x, player_y, " to ", BoardState.grid[player_x][player_y])
		print("old position: ", player_x, player_y, "new position: ", new_position.x, new_position.y)
	else:
		## This should show a custom event card but it is pretty much impossible to ever happen
		print("Nothing happened")
