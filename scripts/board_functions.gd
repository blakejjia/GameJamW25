extends Node2D

const HEX = preload("res://scenes//hexagon.tscn")

# Hex dimensions
const HEX_SIZE = 64  # distance from center to corner
const HEX_WIDTH = HEX_SIZE * sqrt(3)
const HEX_HEIGHT = HEX_SIZE * 2
const OFFSET_X = HEX_WIDTH * 0.7
const OFFSET_Y = HEX_HEIGHT * 0.5
const DEFAULT_COLOR = Color(0.8, 0.8, 0.8)
const PLAYER_COLOR = Color(163, 0, 0)
func draw_board(grid: Array) -> void:
	var screen_center = get_viewport_rect().size / 2
	for col in range(grid.size()):
		for row in range(grid[col].size()):
			var hex = HEX.instantiate()
			# Different colors based on what's in the grid at that position
			if grid[col][row] == 0: hex.hex_color = DEFAULT_COLOR
			elif grid[col][row] == 1: hex.hex_color = PLAYER_COLOR
			add_child(hex)
			
			var x = (col * OFFSET_X) + screen_center[0]
			var y = (row * OFFSET_Y) + (screen_center[1] / 4)
			if row % 2 == 0:
				x += OFFSET_X / 2
			
#			I guess you can just add whatever properties you want to a scene
			hex.position = Vector2(x, y)
			hex.grid_pos = Vector2(col, row)
			hex.hex_clicked.connect(_on_hex_clicked)

func _on_hex_clicked(hex_position):
	print("Hex clicked at: ", hex_position)
