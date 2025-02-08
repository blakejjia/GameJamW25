extends Node

var grid: Array
signal grid_updated

func _ready():
	initialize_grid(6, 6, 2)
	
func initialize_grid(width: int, height: int, player_count: int):
	if player_count > 4 or player_count < 2:
#		Only support 2-4 players, should handle what happens outside of that range better
		return
	grid = []
	for x in range(width):
		grid.append([])
		for y in range(height):
			grid[x].append(0)
	
	if player_count > 0: grid[0][0] = 1 # Top left
	if player_count > 1: grid[-1][-1] = 1 # Bottom right
	if player_count > 2: grid[0][-1] = 1 # Top right
	if player_count > 3: grid[-1][0] = 1 # Bottom left

func set_cell(x: int, y: int, value) -> void:
	grid[x][y] = value
	emit_signal("grid_updated")
