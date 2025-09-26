class_name SlideState extends PlayerMovementState

@export_category("Movement vars")
@export var sliding_speed : float = 18.0
var sliding_timer
@export var sliding_timer_max : float = 1.2
@export var acceleration : float = 0.15
@export var deacceleration : float = 0.3

@export var lerp_Speed : float = 10.0

@export_category("camera category")
@export var camera : Camera3D
@export var added_camera_fov :float = 20.0
@export var current_camera_fov : float = 80.0



func enter()->void:
	sliding_timer = sliding_timer_max
	Player.crouch()



func physics_update(delta : float)-> void:

	sliding_timer-= delta
	camera.fov = lerp(camera.fov , current_camera_fov+added_camera_fov , lerp_Speed*delta)
	Player.update_gravity(delta)
	Player.update_movement((sliding_timer+0.1)*sliding_speed , acceleration , deacceleration)
	if sliding_timer <= 0.0:
		camera.fov = lerp(camera.fov , current_camera_fov , lerp_Speed*delta)
		change_state.emit("IdleState")
	
	if Input.is_action_just_pressed("jump"):
		change_state.emit("JumpState")


func exit()-> void:
	Player.uncrouch()
