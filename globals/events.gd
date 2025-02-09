extends Node

## Stores all the events in this format
## function is the name of the function in scripts/event_scripts/event_functions.gd
## slug is the id of the event in assets/event-cards
var events = [
		{"event_name": "Zombie Encounter!", "probability": 0.3, "function": "zombie_encounter", "slug": "zombie"},
		{"event_name": "Item Farming", "probability": 0.8, "function": "new_item", "slug": "item"},
	]
