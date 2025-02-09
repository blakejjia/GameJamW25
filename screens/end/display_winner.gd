extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_winner(1)

func show_winner(winner:int) -> void:
	var message = "player %s" % str(winner)
	self.text = message
	#$Winner.show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
