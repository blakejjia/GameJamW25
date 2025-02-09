extends Node
class_name Event

var event_name: String
var probability: float  # Between 0 and 1
var effect: Callable

static func create(event_name: String, event_probability: float, event_effect: Callable) -> Event:
	var instance = Event.new()
	instance.event_name = event_name
	instance.probability = event_probability
	instance.effect = event_effect
	return instance
