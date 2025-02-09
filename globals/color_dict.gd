extends Node

# Map corresponding to the tile colors
# Can be modified to contain file paths to assets

var color_dict = {
	-1: Color(0.8, 0.8, 0.8), ## Default color
	-2: Color.YELLOW, ## Event tile color
	
	## Player colors
	0: Color.DARK_RED,
	1: Color.SEA_GREEN,
	2: Color.CADET_BLUE,
	3: Color.PURPLE,
	
	## Event colors
	4: Color.BLACK ## Zombie color
}
