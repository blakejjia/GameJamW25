extends HBoxContainer

var items:Array[String] = ["empty","empty","empty"]:
	set(value):
		items = value
		update_item_display()
var item_assets_path = AssetConstants.item_assets_path
var suffix = AssetConstants.resource_suffix 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_item_display()

func update_item_display():
	$slot1.item = items[0]
	$slot2.item = items[1]
	$slot3.item = items[2]
