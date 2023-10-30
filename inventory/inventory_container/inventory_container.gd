extends Control

var inventory_window = "weapon"
@onready var inventory_background = $VContainer/TextureRect
@onready var texture_rect = $VContainer/TextureRect
@onready var v_container_itens = $VContainer/TextureRect/ScrollContainer/VContainerItens
@onready var animation = $Animation
var is_visible :bool = false

var inventory 	: Array = []

func _ready():

	set_inventory_window(inventory_window)
	
	
func set_inventory_window(name):
	inventory_window = name 
	var inventory_texture = load("res://inventory/inventory arts/inventario_"+name+".png")
	inventory_background.set_texture(inventory_texture)
	set_itens(name)
	
	
func insert_item(type,name,image,data):

	inventory.append([name,image,type,data.get_path()])
	
	if inventory_window == type:
		set_itens(inventory_window)

func valid_amount(value):
	print(inventory)
	print(value)
	if "amount" in str(value) :  
		return value
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
		item_instantiate.set_item(i[0],i[1],i[3],i[2],valid_amount(i[3]))
		v_container_itens.add_child(item_instantiate)
		
