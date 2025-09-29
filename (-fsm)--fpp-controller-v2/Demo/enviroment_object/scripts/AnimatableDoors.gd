class_name AnimatableDoors
extends AnimatableBody3D

@export var DoorAnimationPlayer : AnimationPlayer

func _ready():
	get_animation_player()

func open_door() -> void:
	if DoorAnimationPlayer:
		DoorAnimationPlayer.play("open")
	else:
		return

func close_door()-> void :
	if DoorAnimationPlayer:
		DoorAnimationPlayer.play("close")
	else:
		return

func get_animation_player()-> void:
	for i in get_children():
		if i is AnimationPlayer:
			DoorAnimationPlayer = i
