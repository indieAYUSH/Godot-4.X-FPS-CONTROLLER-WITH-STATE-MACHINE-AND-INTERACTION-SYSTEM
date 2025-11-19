extends InteractionComponent
class_name HoldAbleItem


@export var item_name : String

func _ready():
	super._ready()
	input_prompt = item_name

func on_interacted():
	Global.Player.itme_holdable.pickup_object(item_name)
	get_parent().get_parent().queue_free()
