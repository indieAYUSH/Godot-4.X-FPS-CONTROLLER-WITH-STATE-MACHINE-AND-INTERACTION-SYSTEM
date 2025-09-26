class_name State extends Node

signal change_state(StateName : String)


func enter()->void:
	pass

func exit()-> void :
	pass

func _update(delta : float) -> void:
	pass

func physics_update(delta : float)-> void:
	pass

func _input_update(event):
	pass

func unhandled_input_update(event)->void:
	pass
