class_name PlayerInteractionRay
extends Node

@export var interaction_raycast: RayCast3D
var interaction_cast_result

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
	if interaction_cast_result and interaction_cast_result.has_user_signal("interacted"):
		interaction_cast_result.emit_signal("interacted")
