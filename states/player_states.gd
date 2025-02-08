extends Node

var players: Array
var player_class = load("res://playerInfo/Player.gd")

func _ready():
	players = []

func add_player(player_name, job, player_position):
	var player = player_class.new()
	player.player_name = player_name
	player.job = job
	player.player_position = player_position
	players.append(player)
	
	
