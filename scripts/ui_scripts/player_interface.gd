extends Control

@onready var name_label: Label = $HBoxContainer/VBoxContainer/Name
@onready var avatar_texture: TextureRect = $HBoxContainer/Avatar
@onready var health_label: Label = $HBoxContainer/VBoxContainer/Health
@onready var job_label: Label = $HBoxContainer/VBoxContainer/Job
@onready var item_list: ItemList = $HBoxContainer/ItemList
@onready var container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	item_list.custom_minimum_size = Vector2(100, 50) 
	
func update_name(new_name: String) -> void:
	name_label.text = new_name

func update_avatar(texture_path: String) -> void:
	avatar_texture.texture = load(texture_path)

func update_health(new_health: int) -> void:
	health_label.text = str(new_health)
	
func update_job(new_job: String) -> void:
	job_label.text = new_job
	
func set_item_list(items: Array[String]) -> void:
	item_list.clear()
	for item in items:
		print("adding item: " + item)
		var texture_path = AssetPaths.item_assets_path + item + AssetPaths.resource_suffix
		var texture = load(texture_path)
		if texture == null:
			print("Failed to load texture for: ", item)
		item_list.add_item(item, texture)
	
