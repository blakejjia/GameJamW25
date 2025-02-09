extends TextureRect
#extends 

# Call variables from main
#player1 = 1
#player2 = 2
#player3 = 3
#player4 = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var winner_image = load("res://assets/pictures/athletic.png")
	self.texture = ImageTexture.create_from_image(winner_image)

func show_winner_image(winner):
	#var winner_image = load("res://assets/pictures/athletic.png")
	#self.texture = ImageTexture.create_from_image(winner_image)
	if (winner == 1) :
		pass
	elif (winner == 2) :
		pass
	elif (winner == 3) :
		pass
	else :
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
