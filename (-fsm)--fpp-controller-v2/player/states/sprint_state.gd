class_name SprintState   extends PlayerMovementState

@export_category("Movement vars")
@export var speed : float = 11.0
@export var acceleration : float = 0.15
@export var deacceleration : float  = 0.3
@export var fov_change : float = 8.0



func enter()->void:
	Player.CameraJuice_Component.fov_manager(fov_change)
	



func physics_update(delta : float)-> void:
	Player.update_gravity(delta)
	Player.update_movement(speed , acceleration , deacceleration)
	

func _update(delta : float) -> void:
	if not Input.is_action_pressed("sprint") or Player.input_dir == Vector2.ZERO:
		change_state.emit("WalkState")
		
	if Input.is_action_just_pressed("jump") and Player.is_on_floor():
		change_state.emit("JumpState")
	
	if Input.is_action_just_pressed("crouch") and Player.is_on_floor():
		change_state.emit("SlideState")


func exit()-> void:
	Player.CameraJuice_Component.fov_manager(-fov_change)
	
	
