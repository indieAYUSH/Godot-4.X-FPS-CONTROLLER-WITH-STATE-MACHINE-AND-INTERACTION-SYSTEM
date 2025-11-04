class_name PlayerMovementState extends State

@export var Player : PlayerController
var PlayerAnimation : AnimationPlayer
func _ready():
	await owner.ready
	Player = owner as PlayerController
	PlayerAnimation = Player.get_node("PlayerAnimation") as AnimationPlayer
