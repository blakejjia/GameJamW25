extends Area2D
class_name Hexagon
const HEX = preload("res://hexagon.tscn")

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
	return hex
			
func _on_mouse_entered():
	print("hexagon selected at: " + str(coords[0]) + ", " + str(coords[1]))
