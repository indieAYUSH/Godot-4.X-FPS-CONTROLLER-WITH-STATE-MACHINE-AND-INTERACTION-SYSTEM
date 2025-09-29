class_name InteractionComponent extends Node



@export var input_prompt : String
@export var input_icon : Texture2D
@export var override : bool

@export var mesh : MeshInstance3D


var INTERRACTION_HIGHLIGHT = preload("uid://cn414auvdbt82")


var parent



func _ready():
	parent = get_parent()
	connect_parent()
	_get_mesh()

func in_range():
	print("focused")
	mesh.material_overlay = INTERRACTION_HIGHLIGHT
	MessageBus.UpdateContextMenu.emit(override , input_icon , input_prompt)

func not_in_range():
	print("unfocused")
	mesh.material_overlay = null
	MessageBus.ResetContextMenu.emit()

func on_interacted():
	print("interacted")



func connect_parent():
	
	parent.add_user_signal("focused")
	parent.add_user_signal("unfocused")
	parent.add_user_signal("interacted")
	parent.connect("focused" , in_range)
	parent.connect("unfocused" , not_in_range)
	parent.connect("interacted" , on_interacted)

func _get_mesh() ->void:
	if mesh:
		return
	else:
		for i in parent.get_children():
			if i is MeshInstance3D:
				mesh = i
