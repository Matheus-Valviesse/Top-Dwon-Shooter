extends Control

var inventory_window = "weapon"

@onready var inventory_container = $"."
@onready var inventory_background = $VContainer/TextureRect
@onready var texture_rect = $VContainer/TextureRect
@onready var v_container_itens = $VContainer/TextureRect/ScrollContainer/VContainerItens
@onready var animation = $Animation
var is_visible :bool = false

@onready var weapons_animation = $TextureRect/WeaponsAnimation

var inventory 	: Array = []

var weapons = [null,null]
var weapon_value = 1

func _ready():
	set_inventory_window(inventory_window)
	
func set_inventory_window(name):
	
	inventory_window = name 
	var inventory_texture = load("res://inventory/inventory arts/inventario_"+name+".png")
	inventory_background.set_texture(inventory_texture)
	set_itens(name)
	
func insert_item(type,name,image,data,status):
	
	if type == "potion" or type == "recourses":
		
		var exist_index = -1
		
		for index in range(inventory.size()):
			var item = inventory[index]
			if item[0] == name:
				exist_index = index
				break
				
		if exist_index != -1 :
			inventory[exist_index][4][2] += status[2]
			
			
		else:
			
			inventory.append([name,image,type,valid_path(data),status])
			

	else:
	
		inventory.append([name,image,type,valid_path(data),status])

	
	if inventory_window == type:
		
		set_itens(inventory_window)
	
func valid_path(pathOrNode):

	if pathOrNode is NodePath:
		return pathOrNode
	elif pathOrNode is String:
		return pathOrNode
	else:
		return pathOrNode.scene_file_path
	
func valid_amount(type,value):

	if type == "potion" or type == "recourses":  
		return value[2]
	else :
		return 1
	
	
func set_itens(category):
	
	var itens = v_container_itens.get_children()
	var arr_itens
	
	arr_itens = inventory.filter(func(item): return item[2] == category)
	
	
	for item in itens:
		item.queue_free()

	var load_item = preload("res://inventory/item/item_background.tscn")
	

	for i in arr_itens:

		var item_instantiate =  load_item.instantiate()
		item_instantiate.set_item(i[0],i[1],i[3],i[2],valid_amount(i[2],i[4]),i[4])
		v_container_itens.add_child(item_instantiate)
		item_instantiate.update_item(i[2])
	
func _on_animation_finished(anim_name):
	
	if anim_name == "show":
		set_process(true)
		
	if anim_name == "hide":
		set_process(false)
	
func _input(event):
	if inventory_container.modulate[3] == 1:
		if event.is_action_pressed("mouse_rigth"):
			
			for child in v_container_itens.get_children():
				
				var mouse_p = event.position
				var rect = child.get_global_rect()
				
				if rect.has_point(mouse_p):
					
					var exist_index 
					
					for index in range(inventory.size()):
						
						var item = inventory[index]
						if item[0] == child.item_name:
							exist_index = index
							break
							
					var item = inventory[exist_index]
					var slot_is_null = weapons.find(null)

					set_in_slot(item,exist_index)
					
					if slot_is_null != -1:
						spawn_weapon(slot_is_null)
					
			var slots 
			
			match inventory_window:
				'weapon':
					slots = $Weapons.get_children()
					
			if slots != null:
				for item_i in slots:
					var mouse_p = event.position
					var rect = item_i.get_global_rect()
					
					if rect.has_point(mouse_p):
					
						if item_i.item_name != null and item_i.item_status != null :
									
							insert_item(
								item_i.item_type,
								item_i.item_name,
								item_i.item_texture,
								item_i.item_path,
								item_i.item_status)
								
							match inventory_window:
								'weapon':
									weapons[item_i.item_index] = null

							spawn_weapon(item_i.item_index - 1)
							item_i.reset_item()
							
	if event.is_action_pressed("weapon_1") and weapon_value != 0 and weapons[0] != null:
		spawn_weapon(0)
	if event.is_action_pressed("weapon_2") and weapon_value != 1 and weapons[1] != null:
		spawn_weapon(1)
	
func spawn_weapon(value):

		weapon_value = value
		var weapon
		var weapon_instance
		
		if weapon != null:
			weapon.queue_free()
		if  weapon_instance != null:
			weapon_instance.queue_free()
			
		
		if weapons[weapon_value] != null:
			weapon = load(weapons[weapon_value][3])
			weapon_instance = weapon.instantiate()
			weapon_instance.z_index = 99
			get_parent().get_parent().get_node(".").add_child(weapon_instance)
			
			get_tree().call_group("player","set_weapon",weapon_instance,'spawn')
			return
			
		get_tree().call_group("player","set_weapon",weapon_instance,'delete')
		
func _process(delta):
	pass
	
func set_in_slot(item,i):
	
	if inventory_window == 'weapon':
		var index = weapons.find(null)
		
		if index != -1:
			weapons[index] = [
				item[0],
				item[1],
				item[2],
				item[3],
				item[4]]
			
			var slot = $Weapons.get_child(index)
			slot.item_index = index
			slot.item_name = item[0]
			slot.item_texture = item[1]
			slot.item_type = item[2]
			slot.item_path = item[3]
			slot.item_status = item[4]
			slot.set_item_texture()
			
			inventory.remove_at(i)
			set_inventory_window(inventory_window)

