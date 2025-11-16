extends InteractionComponent
class_name HoldAbleItem


@export var item_resource : HoldAbleItemResource

func _ready():
	super._ready()
	input_prompt = item_resource.name

func on_interacted():
	pass
