extends Control

## This is the data will changing all the time
## might be most important one in the game loop
@export var players_data:Array[Player] = []:
	set(value):
		players_data = value
		update()

@export var player_info_scene: PackedScene

@onready var ui_container = $PlayerInfo

func _ready():
	init()
	update()

## init is a temporary function to make some data for test
## TODO: delete this function
func init():
	var player1 = Player.new()
	var player2 = Player.new()
	player2.health = 2
	player2.job = "doctor"

	players_data.append(player1)
	players_data.append(player2)

## Adjusting user interface based on player state
## creating proper number of player info indicator sets
func update():
	## TODO: see if we need this
	#var base_x = 50  # Starting X position
	#var base_y = 20  # Fixed Y position (top of the screen)
	#var spacing = 200  # Space between players
	## Ensure it scales correctly if the window resizes
	#self.anchor_left = 0
	#self.anchor_top = 0
	#self.anchor_right = 0
	#self.anchor_bottom = 0
	
	for i in players_data:
		var player_ui = player_info_scene.instantiate()

		# places to assign things
		var health:int = player_ui.get_node("info/VBoxContainer/Health").health
		var items:Array[String] = player_ui.get_node("info/VBoxContainer/items").items
		var job:String = player_ui.get_node("info/avatar").job
		
		# assign
		health = i.health
		items = i.items
		job = i.job
		
		ui_container.add_child(player_ui)
