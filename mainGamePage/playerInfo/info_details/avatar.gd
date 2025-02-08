extends TextureRect

## job is set to default in case null pointer
## should be changed when tree build
## TODO:"change default"
@export var job: String = "default":
	set(value):
		job = value
		update_job()

## Avatar_assets_path is get from main.gd, global variables
var avatar_assets_path:String = AssetConstants.avatar_assets_path
var suffix:String = AssetConstants.resource_suffix

## When ready, call update job
func _ready() -> void:
	update_job()

# update_job by it self
func update_job():
	self.texture = load(avatar_assets_path+job+suffix)
	$"../../Job".text=job
