extends Node2D

@onready var board_functions = get_node("Board")
@export var grid_rows: int = 10
@export var grid_cols: int = 12 
@export var player_count: int = 3

## Initializes the global variables
func _ready() -> void:
	BoardState.grid_cols = grid_cols
	BoardState.grid_rows = grid_rows
	GameState.player_count = player_count
	initialize_grid()
	initialize_players()
	board_functions.draw_board()
	for col in HexagonStates.hexagons:
		for hexagon in col:
			hexagon.connect("hex_clicked", on_tile_clicked)

func initialize_grid():
	var grid = BoardState.grid
	if player_count > 4 or player_count < 2:
#		Only support 2-4 players, should handle what happens outside of that range better
		return
	for x in range(grid_cols):
		grid.append([])
		for y in range(grid_rows):
			grid[x].append(-1)

func initialize_players():
	if GameState.player_count > 0:
		BoardState.grid[0][0] = 0 # Top left
		PlayerStates.players.append(Player.create(10, "a", "doctor", 0, 0, [], 0))
	if GameState.player_count > 1: 
		BoardState.grid[-1][-1] = 1 # Bottom right
		PlayerStates.players.append(Player.create(10, "b", "doctor", -1, -1, [], 1))
	if GameState.player_count > 2:
		BoardState.grid[0][-1] = 2 # Top right
		PlayerStates.players.append(Player.create(10, "c", "doctor", 0, -1, [], 2))
	if GameState.player_count > 3:
		BoardState.grid[-1][0] = 3 # Bottom left
		PlayerStates.players.append(Player.create(10, "d", "doctor", -1, 0, [], 3))

## Increments the current turn, then redraws the board
func next_turn():
	GameState.current_turn = (GameState.current_turn + 1) % player_count
	board_functions.update_board()

## Called when a tile is clicked (currently moves the player to that position)
func on_tile_clicked(hex_position):
	var to_x = hex_position[0]
	var to_y = hex_position[1]
	var current_player = PlayerStates.players[GameState.current_turn]
	if is_valid_move(current_player.player_x, current_player.player_y, to_x, to_y):
		BoardState.grid[current_player.player_x][current_player.player_y] = -1
		current_player.player_x = to_x
		current_player.player_y = to_y
		BoardState.grid[to_x][to_y] = current_player.id
		next_turn()

	else:
		print("Invalid move!")

func is_valid_move(from_x: int, from_y: int, to_x: int, to_y: int):
	return true	
