class_name SwipeButton
extends Button


var type
var parent
var used: bool = false


func init(parent, type, texture):
	self.parent = parent
	self.type = type
	$sprite.texture = texture

func after_use():
	type = null
	used = false
	$sprite.texture = null

func _pressed():
	parent.choise(self)


	
	
