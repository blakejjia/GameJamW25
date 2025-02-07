extends Node2D
## This is the script to spawn TheGird based on variables provided
## Auto spawned in center of display
## Will be auto loaded at start time. 

## hex_texture is the texture to be displayed, 
## usually a png picture, should change if state here not land anymore
@export var hex_texture: Texture

## rows determines how many rows are spawned, 
## int value can change if player number changed
@export var rows: int = 5

## cals determines how many cals are spawned, 
## same as rows
@export var cols: int = 5

## Hexsize is the size desired for each grid
## picture will be auto aligned and scaled to this number
@export var hex_size: Vector2 = Vector2(128, 128)

func _ready():
	if hex_texture:
		generate_hex_grid()
	else:
		print("Error: No texture assigned!")

# for future reference
var hex_dict = {}

func generate_hex_grid():
	
	# Scale texture to wanted
	var tex_size = hex_texture.get_size()
	var scale_factor = Vector2(hex_size.x / tex_size.x, hex_size.y / tex_size.y)

	# Calculate grid dimensions
	var grid_width = (cols - 1) * hex_size.x * 0.75 
	var grid_height = (rows - 1) * hex_size.y * 0.65 
	var canvas_center = get_viewport_rect().size / 2
	var grid_offset = canvas_center - Vector2(grid_width / 2, grid_height / 2)

	for row in range(rows):
		for col in range(cols):
			var x_offset = int(row/2)
			var x_pos = (col * hex_size.x * 0.75) + (row * hex_size.x * 0.4) - (hex_size.x * 0.8 * x_offset)+ grid_offset.x
			var y_pos = row * hex_size.y * 0.65 + grid_offset.y
			
			var hex_sprite = Sprite2D.new()
			hex_sprite.texture = hex_texture
			hex_sprite.position = Vector2(x_pos, y_pos)
			hex_sprite.scale = scale_factor

			# Store in dictionary
			var key = Vector2(row, col)
			hex_dict[key] = hex_sprite
			
			# Assign metadata
			hex_sprite.set_meta("row", row)
			hex_sprite.set_meta("col", col)

			add_child(hex_sprite)
			
# To reference the grid:
#var target_hex = hex_dict.get(Vector2(2, 3))  # Get hex at row=2, col=3
#if target_hex:
	#print("Hex found at:", target_hex.position)
