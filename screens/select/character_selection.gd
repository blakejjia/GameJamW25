extends Control

var players_data = [
	Player.new().set_data(10, "David", "Doctor", 3, ["", "", ""], Vector2(1, 2)),
	Player.new().set_data(10, "Colt", "Robbery", 3, ["", "", ""], Vector2(3, 4)),
	Player.new().set_data(10, "Jennifer", "Police", 3, ["", "", ""], Vector2(5, 6)),
	Player.new().set_data(10, "Emily", "Athletic", 3, ["", "", ""], Vector2(7, 8))
]

func _ready():
	for Player in players_data:
		var button = Button.new()
		button.text = "%s - %s" % [Player.player_name, Player.job]
		button.connect("pressed", Callable(self, "_on_CharacterButton_pressed").bind(Player))
		$VBoxContainer.add_child(button)

func _on_CharacterButton_pressed(player: Player):
	select_character(player)

func select_character(player: Player):
	print("Selected character: %s, Role: %s" % [player.player_name, player.job])
