extends Control

@onready var event_name: Label = $Container/EventName
@onready var event_card: TextureRect = $Container/EventCard
@onready var container = $Container

const DISPLAY_TIME = 3.5
const FADE_TIME = 1

func _ready():
	hide()
	modulate.a = 0
	event_name.position = Vector2(100, 0)
	
	container.anchor_left = 0.5
	container.anchor_right = 0.5
	container.anchor_top = 0.5
	container.anchor_bottom = 0.5
	
	## This way of centering is bad, but when I tried the "proper way" it didn't work
	container.position = Vector2(550, 100)

func update_name(new_name: String) -> void:
	event_name.text = new_name
	display()

func update_card(texture_path: String) -> void:
	event_card.texture = load(texture_path)
	display()

func display() -> void:
	# Only start display sequence if not already visible
	if not visible or modulate.a == 0:
		show()
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 1.0, FADE_TIME)
		
		await get_tree().create_timer(DISPLAY_TIME).timeout
		
		tween = create_tween()
		tween.tween_property(self, "modulate:a", 0.0, FADE_TIME)
		await tween.finished
		hide()
