extends Node

var players: Array
var player_count: int
var turn: int # Turn will correspond to the player's index in the players array
var player_class = load("res://mainGamePage/playerInfo/Player.gd")

func initialize_players():
	players = []
	turn = 0
	player_count = 2
	for i in range(player_count):
		add_player("p", "job")
		
func add_player(player_name: String, job: String):
	var player = player_class.new()
	player.player_name = player_name
	player.job = job
	players.append(player)
	
	
