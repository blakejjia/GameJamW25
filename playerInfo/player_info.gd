extends Control

@export var player_count: int = 1
@export var player_info_scene: PackedScene

@onready var ui_container = $PlayerInfo

func _ready():
	init()
	#update_ui()

## Init is adjusting user interface based on player number
## creating proper number of player info indicator sets
func init():
	var base_x = 50  # Starting X position
	var base_y = 20  # Fixed Y position (top of the screen)
	var spacing = 200  # Space between players
	# Ensure it scales correctly if the window resizes
	self.anchor_left = 0
	self.anchor_top = 0
	self.anchor_right = 0
	self.anchor_bottom = 0
	
	for i in range(player_count):
		var player_ui = player_info_scene.instantiate()
		#player_ui.player_number = i + 1  # Set player number
		ui_container.add_child(player_ui)

#func update_ui():
	#player_label.text = "P" + str(player_number)
	#heart_label.text = str(heart) + "❤️"
#
#func add_star(amount: int = 1):
	#heart += amount
	#update_ui()
