extends Node2D

const HEX = preload(ScenePaths.hexagon_path)

# Hex dimensions
const HEX_SIZE = 64  # distance from center to corner
const HEX_WIDTH = HEX_SIZE * sqrt(3)
const HEX_HEIGHT = HEX_SIZE * 2
const OFFSET_X = HEX_WIDTH * 0.7
const OFFSET_Y = HEX_HEIGHT * 0.5

# Draws the board by creating the hexagons
func draw_board() -> void:
	var current_player_x = PlayerStates.players[GameState.current_turn].player_x
	var current_player_y = PlayerStates.players[GameState.current_turn].player_y
	HexagonStates.hexagons = []
	var screen_center = get_viewport_rect().size / 2
	for col in range(BoardState.grid_cols):
		HexagonStates.hexagons.append([])
		for row in range(BoardState.grid_rows):
			var hex = HEX.instantiate()
			
			# Different colors based on what's in the grid at that position
			hex.hex_color = ColorDict.color_dict[BoardState.grid[col][row]]
			add_child(hex)
			
			var x = (col * OFFSET_X) + screen_center[0]
			var y = (row * OFFSET_Y) + (screen_center[1] / 4)
			if row % 2 == 0:
				x += OFFSET_X / 2
			
			hex.position = Vector2(x, y)
			hex.grid_pos = Vector2(col, row)
			## Highlight current player 
			if col == current_player_x and row == current_player_y:
				hex.set_current_player_hex(true)
			else:
				hex.set_current_player_hex(false)

			HexagonStates.hexagons[col].append(hex)

# Recolors the board after the grid values have been changed 
func update_board():
	var current_player_x = PlayerStates.players[GameState.current_turn].player_x
	var current_player_y = PlayerStates.players[GameState.current_turn].player_y
	
	for col in range(BoardState.grid_cols):
		for row in range(BoardState.grid_rows):
			var hex = HexagonStates.hexagons[col][row]
			hex.hex_color = ColorDict.color_dict[BoardState.grid[col][row]]
			hex.last_color = hex.hex_color
			## Highlight current player 
			if col == current_player_x and row == current_player_y:
				hex.set_current_player_hex(true)
			else:
				hex.set_current_player_hex(false)
			hex.update_visuals()

## Sets a board cell's value and updates the corresponding hexagon's color  						
func set_cell(x: int, y: int, value) -> void:
	BoardState.grid[x][y] = value
	var hex = HexagonStates.hexagons[x][y]
	hex.hex_color = ColorDict.color_dict[value]
	hex.update_visuals()
	
