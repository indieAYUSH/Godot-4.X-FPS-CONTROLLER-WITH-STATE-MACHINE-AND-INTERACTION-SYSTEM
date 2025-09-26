class_name PlayerMovementState extends State

@export var Player : PlayerController

func _ready():
	await owner.ready
	Player = owner as PlayerController
