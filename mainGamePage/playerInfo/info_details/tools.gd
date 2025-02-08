extends HBoxContainer

var items:Array[String]:
	set(value):
		items = value
		update_item_display()
var item_assets_path = AssetConstants.item_assets_path
var suffix = AssetConstants.resource_suffix 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_item_display()

func update_item_display():
	$slot1.item = items[0] if items.size() > 0 else "empty"
	$slot2.item = items[1] if items.size() > 1 else "empty"
	$slot3.item = items[2] if items.size() > 2 else "empty"
