extends Control

const MAX_MOVE_DIST = 4
const DEFAULT_HEALTH = 5

@onready var board_functions = get_node("Board")
@onready var game_interface = get_node("GameInterface")
@onready var ui_handler = get_node("UIHandler")
@onready var event_functions = get_node("Events")
@onready var item_functions = get_node("ItemButton/ItemFunctions")
@export var grid_rows: int
@export var grid_cols: int
@export var player_count: int
@export var event_chance: float

var player_interface_scene = preload(ScenePaths.player_interface_path)
var rng = RandomNumberGenerator.new()

## Initializes the global variables
func _ready() -> void:
	BoardState.grid_cols = grid_cols
	BoardState.grid_rows = grid_rows
	GameState.player_count = player_count
	initialize_grid()
	initialize_players()
	board_functions.draw_board()
	item_functions.player_updated.connect(ui_handler.update_player_labels)
	item_functions.board_updated.connect(board_functions.update_board)
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
			var chance = rng.randf()
			if event_chance > chance:
				## Tiles with events will be represented with -2 in the grid
				grid[x].append(-2)
			else:
				grid[x].append(-1)

func initialize_players():
	var grid = BoardState.grid
	## Add players to board
	if GameState.player_count > 0:
		grid[0][0] = 0 # Top left
		PlayerStates.players.append(Player.create(DEFAULT_HEALTH, "a", "doctor", 0, 0, ["empty", "empty", "empty"], 0))
	if GameState.player_count > 1:
		grid[grid.size() - 1][grid[0].size() - 1] = 1 # Bottom right
		PlayerStates.players.append(Player.create(DEFAULT_HEALTH, "b", "athletic", grid.size() - 1, grid[0].size() - 1, ["empty", "empty", "empty"], 1))
	if GameState.player_count > 2:
		grid[0][grid[0].size() - 1] = 2 # Top right
		PlayerStates.players.append(Player.create(DEFAULT_HEALTH, "c", "police", 0, grid[0].size() - 1, ["empty", "empty", "empty"], 2))
	if GameState.player_count > 3:
		grid[grid.size() - 1][0] = 3 # Bottom left
		PlayerStates.players.append(Player.create(DEFAULT_HEALTH, "d", "robber", grid.size() - 1, 0, ["empty", "empty", "empty"], 3))

	## Initialize UI elements
	for i in range(GameState.player_count):
		var player_ui = player_interface_scene.instantiate()
		add_child(player_ui)
		PlayerStates.players[i].ui = player_ui
		player_ui.player_id = i
		ui_handler.update_player_health(DEFAULT_HEALTH, i)
		ui_handler.update_player_name(PlayerStates.players[i].player_name, i)
		ui_handler.update_player_job(PlayerStates.players[i].job, i)
		ui_handler.update_player_items(PlayerStates.players[i].items, i)
		var texture_path = AssetPaths.avatar_assets_path + PlayerStates.players[i].job + AssetPaths.resource_suffix
		ui_handler.update_player_avatar(texture_path, i)
		
		player_ui.position = Vector2(200, 100 + (i * 200))
	ui_handler.update_turn_label()

func update_dead_players():
	for player in PlayerStates.players:
		if player.health <= 0 and player.id not in PlayerStates.dead_player_ids:
			BoardState.grid[player.player_x][player.player_y] = -1
			PlayerStates.dead_player_ids.append(player.id)
			print(player.player_name, " has died")

func check_win_condition():
	if PlayerStates.dead_player_ids.size() == GameState.player_count - 1:
		## Only one player left
		var player_ids = []
		for player in PlayerStates.players:
			player_ids.append(player.id)
		
		for id in player_ids:
			if not id in PlayerStates.dead_player_ids:
				ui_handler.show_win_screen(PlayerStates.players[id])

## Increments the current turn, then updates the board
## Instead of figuring out when to call UI updates from events
	## we can just update all the player labels at the end of each turn
func next_turn():
	update_dead_players()
	check_win_condition()
	var last_turn = GameState.current_turn
	GameState.current_turn = (GameState.current_turn + 1) % player_count
	if GameState.current_turn in PlayerStates.dead_player_ids:
		next_turn()
	event_functions.check_zombie_damage(last_turn)
	board_functions.update_board()
	ui_handler.update_turn_label()
	ui_handler.update_player_labels()

## Called when a tile is clicked (currently moves the player to that position)
func on_tile_clicked(hex_position):
	var to_x = hex_position[0]
	var to_y = hex_position[1]
	var current_player = PlayerStates.players[GameState.current_turn]
	if is_valid_move(current_player.player_x, current_player.player_y, to_x, to_y):
		BoardState.grid[current_player.player_x][current_player.player_y] = -1
		current_player.player_x = to_x
		current_player.player_y = to_y
		var event_flag = false
		if BoardState.grid[to_x][to_y] == -2:
			event_flag = true
		BoardState.grid[to_x][to_y] = current_player.id
		if event_flag:
			event_triggered()
		next_turn()

	else:
		print("Invalid move!")

func is_valid_move(from_x: int, from_y: int, to_x: int, to_y: int):
	## Cannot move to tile you are already on
	if from_x == to_x and from_y == to_y:
		return false

	if abs(from_x - to_x) + abs(from_y - to_y) > MAX_MOVE_DIST:
		return false
		
	var board_value = BoardState.grid[to_x][to_y]
	if board_value < 0:
		return true

func event_triggered():
	var random_value = randf() # Random float between 0 and 1
	var cumulative_probability = 0.0
	for event in EventsState.events:
		cumulative_probability += event.probability
		if random_value <= cumulative_probability:
			print("Triggered event: ", event.event_name)
			ui_handler.show_event(event)
			event.effect.call(GameState.current_turn)
			return
