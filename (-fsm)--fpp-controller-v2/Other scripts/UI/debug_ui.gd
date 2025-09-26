extends CanvasLayer

@onready var fps_data = %FPS_DATA
@onready var state_data = %state_data
@onready var speed_data = %speed_data

@export var PLayer : PlayerController

func _process(delta):
	fps_data.text = str(Engine.get_frames_per_second())
	speed_data.text = str(PLayer.velocity.length())



func _on_player_state_machine_state_changed(StateName):
	state_data.text = str(StateName)
