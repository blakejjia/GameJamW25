extends Sprite2D

var health: float
var player_name: String
var job: String
var player_position: Vector2
var items: Array

func move(to: Vector2):
	BoardState.set_cell(player_position[0], player_position[1], 0)
	BoardState.set_cell(to[0], to[1], 1)
	print("player moved from: {0}, {1} to: {2}, {3}".format([player_position[0], player_position[1], to[0], to[1]]))
	PlayerStates.players[PlayerStates.turn].player_position = BoardState.selected
