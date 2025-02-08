extends Control

## This is the data will changing all the time
## might be most important one in the game loop
@export var players_data:Array[Player] = []:
	set(value):
		players_data = value
		update()

@export var player_info_scene: PackedScene
@onready var ui_container = $info

func _ready():
	init()
	update()

## init is a temporary function to make some data for test
## TODO: delete this function
func init():
	var player1 = Player.new()
	var player2 = Player.new()
	player1.health = 2
	player1.job = "doctor"

	players_data.append(player1)
	players_data.append(player2)

## Adjusting user interface based on player state
## creating proper number of player info indicator sets
func update():	
	for i in players_data:
		var player_ui = player_info_scene.instantiate()

		# places to assign things
		player_ui.get_node("info/VBoxContainer/Health").health = i.health
		player_ui.get_node("info/VBoxContainer/items").items = i.items
		player_ui.get_node("info/avatar").job = i.job
		
		ui_container.add_child(player_ui)
