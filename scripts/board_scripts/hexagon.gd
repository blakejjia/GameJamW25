extends Area2D

signal hex_clicked(hex_position)

var grid_pos: Vector2
var polygon: Polygon2D
var hex_color = Color.WHITE
var last_color = Color.WHITE
var outline: Line2D
var glow_intensity = 2.0 
var is_current = false

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
	
	outline = Line2D.new()
	outline.points = [
		Vector2(32, 0),    # Top
		Vector2(16, 28),   # Top right
		Vector2(-16, 28),  # Top left
		Vector2(-32, 0),   # Bottom left
		Vector2(-16, -28), # Bottom right
		Vector2(16, -28),  # Bottom
		Vector2(32, 0)     # Close the shape
	]
	outline.width = 2.0
	outline.default_color = Color.TRANSPARENT
	add_child(outline)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			hex_clicked.emit(grid_pos) 

## When cursor enters hexagon, make the selected hexagon a bit transparent 
func _on_mouse_entered():
	last_color = hex_color
	polygon.color = Color(last_color.r, last_color.g, last_color.b, 0.7)

## When the hexagon is exited update the color to the previous color value
func _on_mouse_exited():
	polygon.color = last_color
	
func set_current_player_hex(is_current_player: bool):
	is_current = is_current_player
	if is_current:
		outline.width = 4.0
		outline.default_color = Color.YELLOW 
		polygon.modulate = Color(1.5, 1.5, 1.5, 1)
	else:
		outline.width = 2.0
		outline.default_color = Color.TRANSPARENT
		polygon.modulate = Color.WHITE
		
## Update the hexagon color
## Used if the hexagon had its color changed
func update_visuals():
	if is_current:
		set_current_player_hex(true)  # Maintain the current player highlighting
	polygon.color = hex_color
