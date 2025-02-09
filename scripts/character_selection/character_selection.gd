extends Node

var players_data = [
	Player.new().create(10, "David", "Doctor", 1, 2, ["", "", ""], 0),
	Player.new().create(10, "Colt", "Robbery", 3, 4, ["", "", ""], 1),
	Player.new().create(10, "Jennifer", "Police", 5, 6, ["", "", ""], 2),
	Player.new().create(10, "Emily", "Athletic", 7, 8, ["", "", ""], 3)
]

func _ready():
	for Player in players_data:
		var button = Button.new()
		button.text = "%s - %s" % [Player.player_name, Player.job]
		button.connect("pressed", Callable(self, "_on_CharacterButton_pressed").bind(Player))
		#$HBoxContainer.add_child(button)

func _on_CharacterButton_pressed(player: Player):
	select_character(player)

func select_character(player: Player):
	print("Selected character: %s, Role: %s" % [player.player_name, player.job])
	


func _on_select_end_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
