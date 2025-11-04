class_name MouseControllerComponent extends Node


@export_category("Mouse settings")
@export var mouse_capture_mode : Input.MouseMode = Input.MOUSE_MODE_CAPTURED
@export var mouse_senstivity : float  = 0.005

@export_category("refrences")
@export var camera_controller : CameraControllerComponent

var capture_mouse : bool
var mouse_input : Vector2

func _unhandled_input(event):
	capture_mouse = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if capture_mouse:
		mouse_input.x += -event.relative.x * mouse_senstivity
		mouse_input.y += -event.relative.y * mouse_senstivity
		camera_controller._update_rotation(mouse_input)

func _ready():
	Input.mouse_mode = mouse_capture_mode


func _process(delta):
	mouse_input = Vector2.ZERO
