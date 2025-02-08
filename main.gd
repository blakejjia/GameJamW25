extends Node2D

func _ready():
	PlayerStates.initialize_players()
	BoardState.initialize_grid(6, 8, 2)
	BoardState.selected = Vector2(-1, -1)
	PlayerStates.turn = 0

func process_turn():
	var selected_coords = BoardState.selected
	print("selected: " + str(selected_coords[0])  + ", " + str(selected_coords[1]))
	PlayerStates.players[PlayerStates.turn].move(selected_coords)
	selected_coords = Vector2(-1, -1)
	PlayerStates.turn = (PlayerStates.turn + 1) % PlayerStates.player_count	
	GridFunctions.generate_hex_grid(BoardState.grid)
