class_name Car
extends Node2D

enum Details{
	wheel,
	janitor,
}

var details: Array
var details_max_count = 10

func _ready():
	generate_details()

func generate_details():
	for i in range(details_max_count):
		details.append(Details.values()[randi()%len(Details.values())])

func get_detail():
	return details.pop_back()
