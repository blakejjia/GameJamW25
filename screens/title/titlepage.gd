extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Credit.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_show_credit_pressed() -> void:
	$Basic.hide()
	$Credit.show()
