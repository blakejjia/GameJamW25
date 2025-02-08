extends HBoxContainer

## common assets path read from project settings
var common_assets_path:String = AssetConstants.common_assets_path
var suffix:String = AssetConstants.resource_suffix

## should be heart resource
var heart_res = load(common_assets_path+"heart"+suffix)

@export var health: int = 3:
	set(value):
		health = value
		update_health_display()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_health_display()

# Function to update hearts
func update_health_display():
	for i in range(get_child_count()):
		var heart = get_child(i) as TextureRect
		if heart:
			heart.texture = heart_res if i < health else null
			heart.custom_minimum_size = Vector2(40, 40) 
			heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
