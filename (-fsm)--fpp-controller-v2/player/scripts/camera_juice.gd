class_name CameraJuiceComponent extends Node3D

@export_category("Camera Effects")
@export var Camera_tilt: bool
@export var Head_bob : bool


@export var Player : PlayerController
@export var lerp_speed : float = 15.0

@export_category("TILT VARS")
@export var roll_pitch : float = 0.031
@export var roll_side_rot : float  = 0.049
@export var max_speed : float = 9.0

@export_category("Headbob Vars")
@export var bob_pitch : float = 0.05
@export var bob_roll : float = 0.025
@export var bob_up :float = 0.0005
@export var bob_frequncy : float = 7.0

var _step_timer : float = 0.0

func _process(delta):
	var angles  = Vector3.ZERO
	var offsets = Vector3.ZERO
	
	var velocity = Player.velocity.length()
	
	#=======================CAMERA TILT things =================================================#
	if Player.velocity.length() > 0.01 and Camera_tilt:
		var speed_factor = clamp(velocity / max_speed, 0.0, 1.0)
		angles.x = lerp(rotation.x , (roll_pitch* Input.get_axis("forward","baackward"))*speed_factor , delta*lerp_speed)
		angles.z = lerp(rotation.z , -(roll_side_rot*Input.get_axis("left","right"))*speed_factor , lerp_speed*delta )
	
	
	#Headbob Things ===============================================================
	
	var speed = Vector2(Player.velocity.x , Player.velocity.z).length()
	if speed > 0.1 and Player.is_on_floor():
		_step_timer += delta*(speed/bob_frequncy)
		_step_timer = fmod(_step_timer , 1.0)
	else:
		_step_timer = 0.0
	var bob_sin = sin(_step_timer* 2.0 * PI) *0.5
	
	if Head_bob:
		var pitch_delta = bob_sin * deg_to_rad(bob_pitch) * speed
		angles.x -= pitch_delta
		
		var roll_delta = bob_sin*deg_to_rad(bob_roll) * speed
		angles.z -= roll_delta
		
		var up_delta = bob_sin * speed * bob_up
		offsets.y += up_delta
	
	
	
	rotation = angles
	position = offsets
