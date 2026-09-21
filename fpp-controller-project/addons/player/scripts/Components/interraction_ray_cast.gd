class_name InterractionController
extends Node

@export var interaction_raycast: RayCast3D
var interaction_cast_result
@export var obj_pickup_marker : Marker3D
signal set_active_object(obj)


var parent 

var active_object




func _ready() -> void:
	if parent == null:
		parent = owner

func _input(event):
	if event.is_action_pressed("interact"):
		interact()

func _physics_process(delta):
	if interaction_raycast.is_colliding():
		var current_cast_result = interaction_raycast.get_collider()
		if interaction_cast_result != current_cast_result:
			if interaction_cast_result and interaction_cast_result.has_user_signal("unfocused"):
				interaction_cast_result.emit_signal("unfocused")
			interaction_cast_result = current_cast_result
			if interaction_cast_result and interaction_cast_result.has_user_signal("focused"):
				interaction_cast_result.emit_signal("focused")
	else:
		if interaction_cast_result and interaction_cast_result.has_user_signal("unfocused"):
			interaction_cast_result.emit_signal("unfocused")
		interaction_cast_result = null

func interact() -> void:
	if active_object and active_object.has_user_signal("interacted"):
		active_object.emit_signal("interacted" , parent)
		return
	if interaction_cast_result and interaction_cast_result.has_user_signal("interacted"):
		interaction_cast_result.emit_signal("interacted" , parent)


func clr_active_object():
	active_object = null


func _on_set_active_object(obj) -> void:
	active_object = obj
