extends Control

## This is the data will changing all the time
## might be most important one in the game loop
@export var players_data:Array[Player] = []:
	set(value):
		players_data = value
		update()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update() 
	
func update():
	pass
