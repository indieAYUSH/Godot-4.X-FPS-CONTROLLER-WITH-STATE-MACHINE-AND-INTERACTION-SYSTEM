class_name PlayerInteractionRay  extends Node


@export var InteractionRaycast : RayCast3D
var Interaction_cast_result


func _input(event):
	if event.is_action_pressed("interact"):
		interact()
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if InteractionRaycast.is_colliding():
		var current_cast_result = InteractionRaycast.get_collider()
		if Interaction_cast_result != current_cast_result:
			if Interaction_cast_result and Interaction_cast_result.has_user_signal("unfocused"):
				Interaction_cast_result.emit_signal("unfocused")
			Interaction_cast_result = current_cast_result
			if Interaction_cast_result and Interaction_cast_result.has_user_signal("focused"):
				Interaction_cast_result.emit_signal("focused")



func interact() -> void:
	if  Interaction_cast_result and  Interaction_cast_result.has_user_signal("interacted"):
		Interaction_cast_result.emit_signal("interacted")
