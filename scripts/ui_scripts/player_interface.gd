extends Control

@onready var name_label: Label = $Container/Name
@onready var avatar_texture: TextureRect = $Container/Avatar
@onready var health_label: Label = $Container/Health
@onready var job_label: Label = $Container/Job
	
func update_name(new_name: String) -> void:
	name_label.text = new_name

func update_avatar(new_texture: Texture2D) -> void:
	avatar_texture.texture = new_texture

func update_health(new_health: int) -> void:
	health_label.text = str(new_health)
	
func update_job(new_job: String) -> void:
	job_label.text = new_job
	
