extends TextureRect

## item is the String to be loaded and displayed
## will need a "empty.png" indicate slots
@export var item: String = "empty":
	set(value):
		item = value
		update_item()

## item assets path is read from main.gd, a global variable
var item_assets_path:String = AssetConstants.item_assets_path
var suffix:String = AssetConstants.resource_suffix

func _ready() -> void:
	update_item()

func update_item():
	self.texture = load(item_assets_path + item + suffix)
