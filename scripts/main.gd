extends Node2D

@onready var board_functions = get_node("Board")

func _ready() -> void:
	board_functions.draw_board(BoardState.grid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
