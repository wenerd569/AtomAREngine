extends Panel

onready var main: Application = $"/root/Main"

var swipe_started = false
var swipe_start
var minimum_drag = 10
var is_choise = false
var choise_button
onready var car = $Car

var buttons:Array

var sprites = {
	Car.Details.wheel: preload("res://sprites/bomb.png"),
	Car.Details.janitor: preload("res://sprites/arrow.png"),
	Car.Details.tree: preload("res://sprites/elka.png")
}

func _ready():
	car = $Car
	print(car)
	for ch in get_children():
		if ch is SwipeButton:
			buttons.append(ch)
	update_butons()


func update_butons():
	for b in buttons:
		if not b.used:
			var detail = car.get_detail()
			if detail == null:
				b.disabled = true
				return
			b.init(self, detail, sprites[detail])


func _input(event):
	if event.is_action_pressed("click") and is_choise:
		swipe_started = true
		swipe_start = get_global_mouse_position()
	if event.is_action_released("click") and swipe_started:
		swipe_started = false
		var swipe_end = get_global_mouse_position()
		var swipe = swipe_end - swipe_start
		if swipe.length() > minimum_drag:
			swipe_complete(swipe)


func choise(button):
	button.modulate = Color.aquamarine
	is_choise = true
	choise_button = button
	for b in buttons:
		if b != button:
			b.disabled = true
		
func un_choise():
	choise_button.modulate = Color.gray
	is_choise = false
	choise_button.after_use()
	choise_button = null
	for b in buttons:
		b.disabled = false

func swipe_complete(swipe):
	var type = choise_button.type
	un_choise()
	update_butons()
	main.send_to_hud_app(
		{
			"type": "choise",
			"bullet": type,
			"swipex": swipe.x,
			"swipey": swipe.y
		}
	)
	
