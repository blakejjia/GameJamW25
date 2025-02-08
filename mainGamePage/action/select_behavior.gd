extends Control

## This is the data will changing all the time
## might be most important one in the game loop
@export var player:Player:
	set(value):
		player = value
		update()
@export var action_scene: PackedScene

@onready var ui_container = $Action

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update() 
	
func update():
	var action_ui = action_scene.instantiate()
	ui_container.add_child(action_ui)
