class_name FallingState
extends PlayerMovementState

@export_category("Movement vars")
@export var speed : float = 7.5
@export var acceleration : float = 0.15
@export var deacceleration : float  = 0.3
@export var input_multiplier : float = 0.5

@export_category("Camera effects var")
@export var max_camera_rotation : float = 10.0



func physics_update(delta : float)-> void:
	Player.update_gravity(delta)
	Player.update_movement(speed * input_multiplier , acceleration , deacceleration)

func _update(delta : float) -> void:
	var max_speed : float = 11.0
	var vertical_speed = abs(Player.velocity.y)
	var speed_delta = pow(vertical_speed/max_speed ,2)
	speed_delta = clamp(speed_delta , 0.0 , 1.0)
	var rotation_delta = max_camera_rotation * speed_delta
	Player.CameraJuice_Component.rot_pivot_x_rot_amount = rotation_delta

	if Player.is_on_floor():
		change_state.emit("IdleState")
		PlayerAnimation.play("land")

func exit()-> void:
	Player.CameraJuice_Component.rot_pivot_x_rot_amount = 0.0
