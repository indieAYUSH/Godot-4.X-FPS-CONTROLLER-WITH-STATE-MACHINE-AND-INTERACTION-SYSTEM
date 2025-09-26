class_name PlayerController  extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@onready var head = %head
@onready var crouched_collsion_shape = $crouched_collsion_shape
@onready var uncrouched_collision_shape = $uncrouched_collision_shape
@onready var obstacle_checker = %ShapeCast3D
@onready var player_animation = $PlayerAnimation

@export_category("Refrences")
@export var player_statemachine : StateMachine
@export var CameraJuice_Component : CameraJuiceComponent


var input_dir

func _ready():
	obstacle_checker.add_exception(self)
	
func _physics_process(delta):
	# Add the gravity.
	

	# Handle jump.


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()
	






func _update_rotation(rot_value : Vector3) -> void :
	transform.basis = Basis.from_euler(rot_value)




func update_movement(_speed : float , _acceleration : float , Deacceleration :float ):
	input_dir = Input.get_vector("left", "right", "forward", "baackward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x , direction.x * _speed , _acceleration)
		velocity.z = lerp(velocity.z , direction.z * _speed , _acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0,  Deacceleration)
		velocity.z = move_toward(velocity.z, 0,  Deacceleration)



func update_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta


func crouch():
	#head.position.y =  lerp(head.position.y ,  crouch_depth , lerp_speed *delta)
	crouched_collsion_shape.disabled = false
	uncrouched_collision_shape.disabled = true
	player_animation.play("crouch")

func uncrouch():
	#head.position.y =  lerp(head.position.y , 0.6 + crouch_depth , lerp_speed *delta)
	crouched_collsion_shape.disabled = true
	uncrouched_collision_shape.disabled = false
	player_animation.play("uncrouch")
