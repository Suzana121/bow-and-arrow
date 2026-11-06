class_name WeaponConstroller extends Node


@export var curr_weapon : Weapons
@export var weapon_model_parent :Node3D

var curr_weapon_model : Node3D

func _ready() ->void:
	if curr_weapon:
		spawn_weapon_model()
		
		
func spawn_weapon_model():
	if curr_weapon_model:
		curr_weapon_model.queue_free()
	if curr_weapon.weapon_model:
		curr_weapon_model = curr_weapon.weapon_model.instantiate()
		weapon_model_parent.add_child(curr_weapon_model)
		curr_weapon_model.position = curr_weapon.weapon_postion
