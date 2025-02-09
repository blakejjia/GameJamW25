extends Node
class_name Item

var item_name: String
var probability: float  # Between 0 and 1
var effect: Callable
var slug: String

static func create(item_name: String, event_probability: float, item_effect: Callable, slug: String) -> Event:
	var instance = Item.new()
	instance.item_name = item_name
	instance.probability = event_probability
	instance.effect = item_effect
	instance.slug = slug
	return instance
