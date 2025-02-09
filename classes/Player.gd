extends Node

## Class defined like this to be global
class_name Player

var health: int
var player_name: String
var job: String
var player_x: int
var player_y: int
var selected_item: String
var selected_item_index: int
var ui

## id corresponds to the player's turn number and array index in PlayerStates.players
var id: int

var items: Array[String]

static func create(p_health: int, p_player_name: String, p_job: String, p_player_x: int, p_player_y: int, p_items: Array[String], p_id: int) -> Player:
	var instance = Player.new()
	instance.health = p_health
	instance.player_name = p_player_name
	instance.job = p_job
	instance.player_x = p_player_x
	instance.player_y = p_player_y
	instance.items = p_items
	instance.id = p_id
	
	 ## Default values for nothing being selected
	instance.selected_item = "empty"
	instance.selected_item_index = 0
	
	return instance
