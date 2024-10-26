extends Panel

onready var main: Application = $"/root/Main"


func update_pos_x() -> void:
	$OffsetValue.text = str($OffsetSlider.value) + " m"


func update_pos_y() -> void:
	$HeightValue.text = str($HeightSlider.value) + " m"


func update_pos_z() -> void:
	$DistanceValue.text = str($DistanceSlider.value) + " m"


func update_size() -> void:
	$SizeValue.text = str($SizeSlider.value)


func _ready():
	update_pos_x()
	update_pos_y()
	update_pos_z()
	update_size()


func _on_DistanceSlider_value_changed(value):
	update_pos_z()


func _on_OffsetSlider_value_changed(value):
	update_pos_x()


func _on_HeightSlider_value_changed(value):
	update_pos_y()


func _on_SizeSlider_value_changed(value):
	update_size()


func _on_SetupTarget_pressed():
	main.send_to_hud_app(
		{
			"action": "target",
			"auto": "false",
			"pos_x": str($OffsetSlider.value),
			"pos_y": str($HeightSlider.value),
			"pos_z": str($DistanceSlider.value),
			"size": str($SizeSlider.value)
		}
	)


func _on_RandomButton_pressed():
	main.send_to_hud_app(
		{
			"action": "target",
			"auto": "true",
		}
	)
