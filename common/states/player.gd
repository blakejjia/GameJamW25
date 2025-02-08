extends Resource
class_name Player

## health is variable indicating initial health of a player
## should be somthing between 1~3 (strong characters can be 2)
@export var health: int = 3

## This is a place indicating job
## program will automatically find assets based on this string
@export var job: String = "default"

## This is item list
## usually empty when game start, but can be not empty depends of character
@export var items: Array[String] = []

## this is the place where player is on the grid
@export var player_position: Vector2

## player name
@export var player_name: String = "default"
