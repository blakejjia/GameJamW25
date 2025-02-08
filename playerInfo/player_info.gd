extends Control

## This is the data will be given from startup page
## assigned when init in _ready 
var players_data = [
	{
		"health": "100 HP",
		"avatar": "doctor",
		"slot1": "Sword",
		"slot2": "Shield",
		"slot3": "Potion"
	},
	{
		"health": "80 HP",
		"avatar": "doctor",
		"slot1": "Bow",
		"slot2": "Arrow",
		"slot3": "Healing Herb"
	}
]


@export var player_count: int = 1
@export var player_info_scene: PackedScene

@onready var ui_container = $PlayerInfo

func _ready():
	init(players_data)

## Init is adjusting user interface based on player number
## creating proper number of player info indicator sets
func init(players_data: Array):
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

		var health_label = player_ui.get_node("info/VBoxContainer/health")
		var avatar = player_ui.get_node("info/avatar")
		var rank_label = player_ui.get_node("Rank")
		var slot1 = player_ui.get_node("info/VBoxContainer/tools/slot1")
		var slot2 = player_ui.get_node("info/VBoxContainer/tools/slot2")
		var slot3 = player_ui.get_node("info/VBoxContainer/tools/slot3")

		# Apply player-specific values
		health_label.text = players_data[i]["health"]
		rank_label.text = players_data[i]["avatar"]
		#slot1.text = players_data[i]["slot1"]
		#slot2.text = players_data[i]["slot2"]
		#slot3.text = players_data[i]["slot3"]
		
		var avatar_texture = load(get_avatar_path(players_data[i]["avatar"]))
		if avatar_texture:
			avatar.texture = avatar_texture
		
		ui_container.add_child(player_ui)

func get_avatar_path(name:String) -> String:
	return "res://assets/pictures/"+name+".jpg"
