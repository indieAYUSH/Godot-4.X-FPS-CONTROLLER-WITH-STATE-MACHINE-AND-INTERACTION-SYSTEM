extends Area3D

func _ready():
	connect("interacted" , add_key)

func add_key():
	Global.Player.door_key = true
	queue_free()
	MessageBus.ResetContextMenu.emit()
