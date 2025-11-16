extends Node3D
class_name item_holder

@export var context_override : bool
@export var has_item : bool 

var can_hold_item : bool
var item
var item_resource : HoldAbleItemResource


func add_item(resource : HoldAbleItemResource ):
	if has_item:
		remove_itme()
	var scene = resource.scene.instantiate()
	add_child(scene)
	position = item_resource.position
	scale = item_resource.scale
	rotation = Vector3(deg_to_rad(item_resource.rotation.x) , deg_to_rad(item_resource.rotation.y) , deg_to_rad(item_resource.rotation.z))

func remove_itme():
	item.queue_free()
