extends Application


func _ready() -> void:
	api('connect_to_hud_app', {
		'target_node' : self,
		'on_message' : 'on_message',
		'on_error' : 'on_error',
		'on_connected' : 'on_connected',
		'on_disconnected' : 'on_disconnected',
	})
	
	api('connect_to_input', {
		'target_node' : self,
		'on_input' : 'on_input'
	})


func on_message(message):
	print("Message from HUD:", message)
	$Messages.text += '[Message]: '+message+'\n'


	$Messages.text += '[Event]: Connected\n'
	api('send_to_hud_app', {
		'type' : 'text',
		'text' : 'Hello from SWP!'
	})


func on_disconnected():
	$Messages.text += '[Event]: Disconnected\n'


func on_error(error_text:String):
	$Messages.text += '[Error]: '+error_text+'\n'


func on_input(type, state):
	print('input_type: ', type, ', state: ', state)
	api('send_to_hud_app', {
		'type' : 'input',
		'input_type' : type,
		'state' : state
	})


func send_to_hud_app(data: Dictionary):
	api('send_to_hud_app', data)
