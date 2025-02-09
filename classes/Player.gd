extends Node
class_name Player

var health: float
var player_name: String
var job: String
var player_x: int
var player_y: int
var id: int 
var items: Array

static func create(p_health: float, p_player_name: String, p_job: String, p_player_x: int, p_player_y: int, p_items: Array, p_id: int) -> Player:
	var instance = Player.new()
	instance.health = p_health
	instance.player_name = p_player_name
	instance.job = p_job
	instance.player_x = p_player_x
	instance.player_y = p_player_y
	instance.items = p_items
	instance.id = p_id
	return instance
