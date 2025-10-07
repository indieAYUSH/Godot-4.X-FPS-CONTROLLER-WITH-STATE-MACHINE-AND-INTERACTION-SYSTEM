class_name DoorComponent
extends Node

@export var input_prompt_override : String
@export var locked : bool
@export var Interaction_Component : InteractionComponent


var parent
var is_open : bool

func _ready():
	parent = get_parent()
	parent.connect("interacted" , door_func )

func door_func()->void:
	if locked:
		pass
	
	if !locked:
		if is_open:
			parent.close_door()
			input_prompt_override = "Open Door"
			is_open = false
		else:
			parent.open_door()
			input_prompt_override = "Close Door"
			is_open = true
	if  Interaction_Component:
		Interaction_Component.input_prompt = input_prompt_override
		MessageBus.UpdateContextMenu.emit(Interaction_Component.override ,Interaction_Component.input_icon , Interaction_Component.input_prompt)


	
