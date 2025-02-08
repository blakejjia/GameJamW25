extends Area2D
class_name Hexagon
const HEX = preload("res://mainGamePage/TheGrid/hexagon.tscn")

var coords: Vector2

func create_hexagon(position: Vector2, row: int, col: int) -> Hexagon:
	coords = Vector2(col, row)
	var hex = HEX.instantiate()
	var shape = CircleShape2D.new()
	shape.radius = 64
	var collision = CollisionShape2D.new()
	collision.shape = shape
	collision.position = position
	collision.debug_color = Color(0, 0, 0, 1)
	hex.add_child(collision)
	hex.mouse_entered.connect(_on_mouse_entered)
	hex.input_event.connect(_on_input_event)
	return hex
			
func _on_mouse_entered():
	pass

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			BoardState.selected = coords
			Main.process_turn()
