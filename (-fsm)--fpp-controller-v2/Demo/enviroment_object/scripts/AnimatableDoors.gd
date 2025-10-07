class_name AnimatableDoors
extends AnimatableBody3D

@export_category("Refrences")
@export var DoorAnimationPlayer : AnimationPlayer
@export var doorcomponent : DoorComponent

@export_category("Animation vars")
@export var DoorOpenAnimation : String = "open"
@export var DoorClosingAnimation : String  = "close"


@export_category("Other variable")
@export var automatic_door_wait_time : float = 3.0
@export var Automatic_Closing : bool

func _ready():
	get_animation_player()
	DoorAnimationPlayer.animation_finished.connect(door_animation_finished)


func open_door() -> void:
	if DoorAnimationPlayer:
		DoorAnimationPlayer.play(DoorOpenAnimation)
	else:
		return

func close_door()-> void :
	if DoorAnimationPlayer:
		DoorAnimationPlayer.play(DoorClosingAnimation)
	else:
		return

func get_animation_player()-> void:
	DoorAnimationPlayer = get_node_or_null("AnimationPlayer")

func door_animation_finished(anim_name:String) -> void:
	if anim_name == DoorOpenAnimation and Automatic_Closing:
		await get_tree().create_timer(automatic_door_wait_time).timeout
		close_door()
		doorcomponent.door_func()
