extends CenterContainer

@export var input_promt_icon :TextureRect
@export var input_prompt : Label
@export var default_icon : Texture2D


# Called when the node enters the scene tree for the first time.
func _ready():
	MessageBus.UpdateContextMenu.connect(update_context_menu)
	MessageBus.ResetContextMenu.connect(reset_context_menu)
	reset_context_menu()





func update_context_menu(override:bool , icon : Texture2D , text:String) -> void:
	if override:
		input_promt_icon.texture = icon
	else:
		input_promt_icon.texture = default_icon
	input_prompt.text = text

func reset_context_menu()-> void:
	input_promt_icon.texture = null
	input_prompt.text =""
	
