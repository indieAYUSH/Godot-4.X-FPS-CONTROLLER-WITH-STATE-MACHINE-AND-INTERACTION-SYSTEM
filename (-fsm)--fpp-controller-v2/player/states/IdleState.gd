class_name IdleState extends PlayerMovementState

@export_category("Movement vars")
@export var speed : float = 7.5
@export var acceleration : float = 0.15
@export var deacceleration : float  = 0.25

func _update(delta):
	if Player.is_on_floor() and Player.velocity.length() > 0.1:
		change_state.emit("WalkState")
	
	if Input.is_action_pressed("crouch") and Player.is_on_floor():
		change_state.emit("CrouchState")
	
	if Input.is_action_just_pressed("jump") and Player.is_on_floor():
		change_state.emit("JumpState")

func physics_update(delta : float)-> void:
	Player.update_gravity(delta)
	Player.update_movement(speed , acceleration , deacceleration)
