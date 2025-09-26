class_name JumpState  extends PlayerMovementState

@export var jump_force : float = 4.5
@export var speed : float = 6.0
@export var acceleration : float = 0.15
@export var deacceleration : float  = 0.25
@export var InputMultiplier : float = 0.65

func enter()->void:
	Player.velocity.y += jump_force

func _update(delta : float) -> void:
	if Player.is_on_floor():
		change_state.emit("IdleState")

func physics_update(delta : float)-> void:
	Player.update_gravity(delta)
	Player.update_movement(speed*InputMultiplier , acceleration , deacceleration)
