extends CharacterBody2D

var take_item = null
var weapon_status
var equippedWeapon
var arma_instance 

var moveSpeed = 400

@onready var player = $"."

@onready var arm = $Arm
@onready var hand = $Arm/Hand

func _physics_process(delta):

	get_input()
	move_and_slide()
	hand_move(delta)
	
func get_input():
	var input_direction = Input.get_vector("left","rigth","up","down")
	velocity = input_direction * moveSpeed
	
	if Input.is_action_just_pressed("take"):
		if take_item != null:
			var exist = "weapon_status" in take_item
			
			if exist != false:
				
				get_tree().call_group("inventory","insert_item",
				take_item.weapon_status["type"],
				take_item.weapon_status["weapon_name"],
				take_item.weapon_status["weapon_texture"], 
				take_item, 
				take_item.weapon_status)
			else :
			
				get_tree().call_group("inventory","insert_item",
				take_item.item_type,
				take_item.item_name,
				take_item.item_texture, 
				take_item, 
				take_item.item_status)
				
			take_item.queue_free()
			take_item = null
	
func hand_move(delta):
	
	var mouse_pos = get_global_mouse_position() 
	
	arm.look_at(mouse_pos)
	
	if equippedWeapon != null:
		
		if equippedWeapon.can_attack == true:
			
			# Atualiza o angulo da arma para seguir o mouse
			var target_rotation = atan2(mouse_pos.y - equippedWeapon.global_position.y, mouse_pos.x - equippedWeapon.global_position.x) 
			equippedWeapon.global_rotation = lerp_angle(equippedWeapon.global_rotation, target_rotation, delta * 8)
		
			# Atualiza a posição da arma para seguir o braço
			equippedWeapon.global_position = equippedWeapon.global_position.lerp(hand.global_position, delta * 15)
		
		if equippedWeapon.can_attack == false:
			equippedWeapon.global_position = hand.global_position
		
		#flipa o sprite dependendo da posicao do mouse
		if equippedWeapon.weapon_status["weapon_type"] == "range":
			if mouse_pos.x > player.global_position.x:
				equippedWeapon.sprite.flip_v = false
			else:
				equippedWeapon.sprite.flip_v = true
		else:
			if mouse_pos.x > player.global_position.x:
				equippedWeapon.sprite.flip_h = false
			else:
				equippedWeapon.sprite.flip_h = true
	
func _on_item_area_colision_entered(area):
	if area.z_index == 0:
		take_item = area
	
func _on_item_area_colision_area_exited(area):
	take_item = null

func set_weapon(weapon,type):
	var instantiate_weapon
	
	if instantiate_weapon != null:
		instantiate_weapon.queue_free()
	if equippedWeapon != null:
		equippedWeapon .queue_free()
	
	if type == 'spawn':
		instantiate_weapon = weapon
		instantiate_weapon.global_position =  hand.global_position
		equippedWeapon = instantiate_weapon
