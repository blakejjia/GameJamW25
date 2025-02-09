extends Control

@onready var name_label: Label = $Container/Name
@onready var avatar_texture: TextureRect = $Container/Avatar
@onready var health_label: Label = $Container/Health
@onready var job_label: Label = $Container/Job
@onready var item_list: ItemList = $Container/ItemList

func update_name(new_name: String) -> void:
	name_label.text = new_name

func update_avatar(texture_path: String) -> void:
	avatar_texture.texture = load(texture_path)

func update_health(new_health: int) -> void:
	health_label.text = str(new_health)
	
func update_job(new_job: String) -> void:
	job_label.text = new_job
	
func set_item_list(items: Array[String]) -> void:
	for item in items:
		var texture_path = AssetPaths.item_assets_path + item + AssetPaths.resource_suffix
		var texture = load(texture_path)
		item_list.add_item(item, texture)
	
