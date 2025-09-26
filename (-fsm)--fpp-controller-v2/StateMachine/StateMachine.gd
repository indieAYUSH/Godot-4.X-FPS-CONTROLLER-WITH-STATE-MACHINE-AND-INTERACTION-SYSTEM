class_name StateMachine extends Node

signal state_changed(StateName : String)

@export var current_state : State

var States : Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			States[child.name] = child
			child.change_state.connect(on_change_state)
		else :
			push_warning("wrong state")
	await owner.ready
	current_state.enter()
	state_changed.emit(current_state.name)

func _process(delta):
	if current_state:
		current_state._update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func _input(event):
	if current_state:
		current_state._input_update(event)

func _unhandled_input(event):
	if current_state:
		current_state.unhandled_input_update(event)

func on_change_state(StateName:String):
	var new_state = States.get(StateName)
	
	if current_state == new_state:
		return
	
	if new_state == null:
		return
	if current_state == null:
		return
	
	if current_state != new_state:
		print(current_state.name)
		current_state.exit()
		new_state.enter()
		current_state = new_state
		state_changed.emit(current_state.name)
