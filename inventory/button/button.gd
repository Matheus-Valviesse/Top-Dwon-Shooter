extends Control

@export var button_name : String

func _on_weapon_button_down():
	get_tree().call_group("inventory","set_inventory_window",button_name)
	
