class_name InteractionCondition
extends Node


signal interaction_condition_sucess
signal interaction_condition_failed

var _owner


enum ConditionType {
	DEFAULT , 
	TOGGLE ,
	MASH ,
}

@export var int_condition_type : ConditionType

@export_group("Mash data")
@export  var mash_pressure : float = 2.5
@export var  pressure_deductor : float = 8.0
@export var mash_pressure_threshold : float = 10.0

var current_mash_pressure : float



@export_group("lock/puzzle data")
@export var has_req_item  : bool = true
@export var item_key_id : String


@export_group("UI context prompt")
@export var requires_ui_context : bool = false
@export var condition_failed_prompt : String
@export var condition_sucess_prompt : String


var current_pressure_progress : float


func _ready() -> void:
	if _owner == null:
		_owner = owner
	_owner.connect("focused" , _interactor_focused)

func _on_object_interacted() -> void:
	match  int_condition_type:
		ConditionType.DEFAULT:
			return
		ConditionType.TOGGLE:
			if !has_req_item:
				check_itme(item_key_id)
				return
			_interaction_condition_sucess()
			
		ConditionType.MASH:
			if !has_req_item:
				check_itme(item_key_id)
				return
			_handle_mash()


func _handle_mash():
	current_mash_pressure += mash_pressure
	if current_mash_pressure > mash_pressure_threshold:
		_interaction_condition_sucess()



func _interaction_condition_sucess() -> void:
	interaction_condition_sucess.emit()

func _interaction_condition_failed() -> void:
	interaction_condition_failed.emit()

func _process(delta: float) -> void:
	if int_condition_type == ConditionType.MASH and current_mash_pressure > 0.0:
		current_mash_pressure -= pressure_deductor*delta
		current_pressure_progress = current_mash_pressure/mash_pressure_threshold
	


func check_itme(_item_id : String):
	if item_key_id == item_key_id:
		has_req_item = true

func _interactor_focused():
	if int_condition_type == ConditionType.MASH:
		MessageBus.update_progress_bar_context.emit(self)
		
