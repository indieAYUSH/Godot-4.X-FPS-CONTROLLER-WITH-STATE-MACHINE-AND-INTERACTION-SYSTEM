class_name PickupComponent
extends Node

var parent : RigidBody3D


var picked_up : bool = false
var picked_up_pivot : Marker3D
var object_mass : float

@export var max_obj_mass_threshold : float = 20.0
@export var object_rotation_senstivity : float = 0.25

@export var damping_strength : float = 23.0
@export var pickup_strength : float = 120.0
@export var max_linear_vel_threshold : float = 16.0
@export var drop_distance_threshold : float = 3.5
@export var original_gravity_scale : float = 1.0


var interactor



func _ready() -> void:
	
	if !parent:
		parent = owner as RigidBody3D
	
	parent.connect("interacted" , _on_interacted)
	
	object_mass = parent.mass
	original_gravity_scale = parent.gravity_scale
	object_rotation_senstivity = clamp(object_rotation_senstivity - (object_mass/max_obj_mass_threshold) , 0.0 , 0.15)

func _on_interacted(_interactor : PlayerController)->void:     # rn for convinient i have used static type player controller but u should remove it if u want enemies or other body to use and pickup same  object
	if object_mass > max_obj_mass_threshold: return
	if picked_up:
		_drop()
		return
	picked_up = true
	parent.gravity_scale = 0.0
	parent.lock_rotation = true
	interactor = _interactor
	picked_up_pivot = interactor.interaction_controller_component.obj_pickup_marker
	interactor.interaction_controller_component.set_active_object.emit(parent)
	parent.emit_signal("set_input_prompt" , "Drop")

func _drop():
	parent.emit_signal("set_input_prompt" , "PickUp4")
	picked_up = false
	parent.freeze = false
	picked_up_pivot = null
	parent.gravity_scale = original_gravity_scale
	interactor.interaction_controller_component.clr_active_object()
	parent.lock_rotation = false
	interactor = null
	
	


func _physics_process(delta: float) -> void:
	if !picked_up: 
		return
	
	var target_pos := picked_up_pivot.global_position
	var displacement := target_pos - parent.global_position
	var acceleration := displacement * pickup_strength
	var damping := -parent.linear_velocity * damping_strength
	var force := (acceleration + damping)
	parent.apply_central_force(force)
	if parent.linear_velocity.length() > max_linear_vel_threshold or displacement.length() > drop_distance_threshold:
		_drop()

func _throw_object(_force : float , _throw_dir : Vector3)->void:
	_drop()
	parent.linear_velocity = _force * _throw_dir
	

func rotate_object(_rot_vector : Vector3)->void:
	parent.rotation.x += deg_to_rad(_rot_vector.y * object_rotation_senstivity)
	parent.rotation.y += deg_to_rad(_rot_vector.x * object_rotation_senstivity)
