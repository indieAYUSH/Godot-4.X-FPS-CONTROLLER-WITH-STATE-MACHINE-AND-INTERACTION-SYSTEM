class_name DoorComponent
extends Node

@export var input_prompt_override : String
@export var locked : bool
@export var Interaction_Component : InteractionComponent

@export_group("locked var")
@export var warning : String = "Bring A key!!!"
@export var Locked_Input_Prompt : String = "Unlock"

var parent
var is_open : bool

func _ready():
	parent = get_parent()
	parent.connect("interacted" , door_func )
	if locked:
		input_prompt_override = Locked_Input_Prompt
		Interaction_Component.input_prompt = input_prompt_override

func door_func()->void:
	if locked:
		unlock_door()
		return


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
func unlock_door() -> void: # U can replace this later with ur inventory code
	if Global.Player.door_key:
		locked = false
		Locked_Input_Prompt = "Open Door"
		warning = "Door Unlocked Sucessfully!!!"
		MessageBus.warningContextMenu.emit(warning)
		input_prompt_override = Locked_Input_Prompt
	else :
		MessageBus.warningContextMenu.emit(warning)
