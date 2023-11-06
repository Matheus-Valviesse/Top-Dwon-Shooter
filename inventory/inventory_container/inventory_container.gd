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

func _ready():
	set_process(false)
	set_process_input(false)
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
			
			inventory.append([name,image,type,data.get_path(),status])
			

	else:
	
		inventory.append([name,image,type,data.get_path(),status])

	
	if inventory_window == type:
		
		set_itens(inventory_window)
	
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
		set_process_input(true)
		
	if anim_name == "hide":
		set_process(false)
		set_process_input(false)

func _input(event):
	
	
	if event.is_action_pressed("mouse_rigth"):
		for child in v_container_itens.get_children():
			
			var mouse_p = event.position
			var rect = child.get_global_rect()
			
			if rect.has_point(mouse_p):
				print(child.item_name)
			else:
				print("nada")

func _process(delta):
	pass


