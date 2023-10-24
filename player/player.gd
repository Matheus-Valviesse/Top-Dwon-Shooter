extends CharacterBody2D

var weapon = null
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
		if equippedWeapon.weapon_type == "range":
			if mouse_pos.x > player.global_position.x:
				equippedWeapon.sprite.flip_v = false
			else:
				equippedWeapon.sprite.flip_v = true
		else:
			if mouse_pos.x > player.global_position.x:
				equippedWeapon.sprite.flip_h = false
			else:
				equippedWeapon.sprite.flip_h = true
	
