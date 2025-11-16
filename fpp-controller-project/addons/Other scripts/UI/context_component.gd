extends CenterContainer

@export var input_promt_icon :TextureRect
@export var input_prompt : Label
@export var default_icon : Texture2D
@export var warning_reffrence : Label
@export var UIAnimationPlayer : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	MessageBus.UpdateContextMenu.connect(update_context_menu)
	MessageBus.ResetContextMenu.connect(reset_context_menu)
	MessageBus.warningContextMenu.connect(show_warning)
	UIAnimationPlayer.animation_finished.connect(ui_animation_finished)
	reset_context_menu()
	reset_warning_context()




func update_context_menu(override:bool , icon : Texture2D , text:String) -> void:
	if override:
		input_promt_icon.texture = icon
	else:
		input_promt_icon.texture = default_icon
	input_prompt.text = text

func reset_context_menu()-> void:
	input_promt_icon.texture = null
	input_prompt.text =""

func show_warning(warning_text : String):
	warning_reffrence.text =  warning_text
	UIAnimationPlayer.play("warning")

func ui_animation_finished(anim_name : String):
	if anim_name == "warning":
		reset_warning_context()

func reset_warning_context() -> void:
	warning_reffrence.text = ""
	warning_reffrence.visible  = false
