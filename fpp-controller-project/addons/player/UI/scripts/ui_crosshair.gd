extends CenterContainer

@export var crosshair_lines : Array[Line2D]
@export var Player : PlayerController
@export var CROSSHAIR_SPEED : float = 0.25
@export var Crosshair_Distance : float = 2.0

@export var DOT_COLOR = Color.WHITE
@export var DOT_RADIUS : float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	draw_circle(Vector2(0,0),DOT_RADIUS,DOT_COLOR)

func adjust_crosshair_lines():
	var player_velocity = Player.get_real_velocity()
	var pos = Vector2(0,0)
	var origin = Vector3(0,0,0)
	var speed = origin.direction_to(player_velocity)
	#crosshair_lines[0].position = lerp(crosshair_lines[0].position , pos + Vector2(0,-speed*Crosshair_Distance),CROSSHAIR_SPEED)
	#
