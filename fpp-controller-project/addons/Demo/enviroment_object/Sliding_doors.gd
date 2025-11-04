class_name SlindinDoor
extends AnimatableDoors

#
#@export var doorcomponent : DoorComponent
#
#@export_category("Other variable")
#@export var automatic_door_wait_time : float = 3.0
#@export var Automatic_Closing : bool
#
#func _ready():
	#if DoorAnimationPlayer:
		#DoorAnimationPlayer.animation_finished.connect(door_animation_finished)
#
#func door_animation_finished(anim_name:String) -> void:
	#if anim_name == DoorOpenAnimation and Automatic_Closing:
		#await get_tree().create_timer(automatic_door_wait_time).timeout
		#close_door()
		#doorcomponent.door_func()
