class_name WalkState extends PlayerMovementState

@export_category("Movement vars")
@export var speed : float = 7.5
@export var acceleration : float = 0.15
@export var deacceleration : float  = 0.25


func _update(delta:float):
	print(Input.get_axis("forward" , "baackward") )
	if Player.velocity.length() < 0.01 :
		change_state.emit("IdleState")
	
	if Input.is_action_pressed("sprint") and Player.is_on_floor() and Input.get_axis("baackward" , "forward") > 0.1:
		change_state.emit("SprintState")
	
	if Input.is_action_pressed("crouch") :
		change_state.emit("CrouchState")
	
	if Input.is_action_just_pressed("jump") and Player.is_on_floor():
		change_state.emit("JumpState")

func physics_update(delta : float)-> void:
	Player.update_movement(speed , acceleration , deacceleration)
	Player.update_gravity(delta)
