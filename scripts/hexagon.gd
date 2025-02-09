extends Area2D

signal hex_clicked(hex_position)

var grid_pos: Vector2
var polygon: Polygon2D
var hex_color = Color.WHITE
var last_color = Color.WHITE

func _ready():
	position = Vector2(-100, -100) # default to out of bounds
	var collision_shape = CollisionPolygon2D.new()
	var points = PackedVector2Array([
		Vector2(32, 0),    # Top
		Vector2(16, 28),   # Top right
		Vector2(-16, 28),  # Top left
		Vector2(-32, 0),   # Bottom left
		Vector2(-16, -28), # Bottom right
		Vector2(16, -28)   # Bottom
	])
	collision_shape.polygon = points
	add_child(collision_shape)

	# For visual display, draw the hexagon
	polygon = Polygon2D.new()
	polygon.polygon = points
	polygon.color = hex_color
	add_child(polygon)

	# Connect the input events
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			hex_clicked.emit(grid_pos) 

func _on_mouse_entered():
	last_color = hex_color
	polygon.color = Color(last_color.r, last_color.g, last_color.b, 0.7)

func _on_mouse_exited():
	polygon.color = last_color
	
func update_visuals():
	polygon.color = hex_color
