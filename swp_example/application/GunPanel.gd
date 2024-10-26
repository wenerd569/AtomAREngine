extends Panel

onready var main: Application = $"/root/Main"

var angle_z: float = 30.0
var angle_x: float = 0.0
var power: float = 30.0

var change_angle_z: bool = false
var change_angle_x: bool = false


func _ready() -> void:
	update_angle_z()
	update_angle_x()
	update_power()


func update_angle_z() -> void:
	$AngleZValue.text = str(angle_z)


func update_angle_x() -> void:
	$AngleXValue.text = str(angle_x)


func update_power() -> void:
	$PowerValue.text = str(power)


func _input(event):
	if event is InputEventMouseMotion:
		if change_angle_z:
			var vector: Vector2 = event.position - ($AngleZButton.rect_position + $AngleZButton.rect_size / 2)
			var relative_rotation: float = vector.angle_to(vector + event.relative)
			
			if (angle_z + relative_rotation) < 30.0:
				relative_rotation = 30.0 - angle_z
			elif (angle_z + relative_rotation) > 70.0:
				relative_rotation = 70.0 - angle_z
			
			angle_z += relative_rotation
			$AngleZButton.rect_rotation += rad2deg(relative_rotation)
			update_angle_z()
		if change_angle_x:
			var vector: Vector2 = event.position - ($AngleXButton.rect_position + $AngleXButton.rect_size / 2)
			var relative_rotation: float = vector.angle_to(vector + event.relative)
			
			if (angle_x + relative_rotation) < -60.0:
				relative_rotation = -60.0 - angle_x
			elif (angle_x + relative_rotation) > 60.0:
				relative_rotation = 60.0 - angle_x
			
			angle_x += relative_rotation
			$AngleXButton.rect_rotation += rad2deg(relative_rotation)
			update_angle_x()


func _on_AngleZButton_button_down() -> void:
	change_angle_z = true
	change_angle_x = false


func _on_AngleXButton_button_down() -> void:
	change_angle_z = false
	change_angle_x = true


func _on_PowerSlider_drag_started():
	_on_angle_button_released()


func _on_angle_button_released() -> void:
	change_angle_z = false
	change_angle_x = false


func _on_PowerSlider_value_changed(value):
	power = value
	update_power()


func _on_ShootButton_pressed():
	main.send_to_hud_app(
		{
			"action": "shoot",
			"angle_x": str(deg2rad(angle_x)),
			"angle_z": str(deg2rad(angle_z)),
			"power": str(power)
		}
	)
