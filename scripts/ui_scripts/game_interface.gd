extends Control

@onready var turn_label: Label = $Turn

func _ready() -> void:
	position = Vector2(30, 30)

func update_turn(new_turn: String) -> void:
	turn_label.text = new_turn
