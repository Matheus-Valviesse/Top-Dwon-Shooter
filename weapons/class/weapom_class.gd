extends Area2D

class_name Weapon

var Bullet = preload("res://bullets/bullet.tscn")
var capsule = preload("res://capsule.tscn")

var weapon
var bulletSpawn 
@onready var sprite = $Sprite2D
@onready var animation_weapon = $AnimationPlayer

var can_fire = true
var can_attack = true

var damage : int
var ammo : int
var maxAmmo : int
var reloadTime : float
var bullet_speed : int

var item_type = "weapon"
var weapon_type : String
var weapon_Style : String
var weapon_name : String
var weapon_texture : String
var bullet_name : String

func _process(delta):
	
	if weapon_Style == "melee" and can_attack == true:
		animation_weapon.play(weapon_name + "_idle")
		
func shoot(type):
	if ammo > 0 :
		can_fire = false
		ammo -= 1
		
		if weapon_Style == "multShoot":
			animation_weapon.play("shoot-2")
		else:	
			animation_weapon.play("shoot")
			
		if type == "barrageShoot":
			var num_projeteis = 8
	
			for i in range(num_projeteis):
				var spawned_bullet = Bullet.instantiate()
				get_parent().add_child(spawned_bullet)
				var random_angle = deg_to_rad(randf_range(-45, 45))  # Intervalo de -30 a 30 graus
				var random_speed = randf_range(bullet_speed - 50, bullet_speed + 50)  # Intervalo de -50 a 50 da velocidade padrão
				spawned_bullet.rotation = global_rotation + random_angle
				spawned_bullet.position = bulletSpawn.global_position
				spawned_bullet.velocity = Vector2(random_speed, 0).rotated(global_rotation + random_angle)   
				spawned_bullet.bullet_anim(bullet_name)
		else:
			var spawned_bullet = Bullet.instantiate()
			get_parent().add_child(spawned_bullet)
			spawned_bullet.rotation = weapon.global_rotation
			spawned_bullet.position = bulletSpawn.global_position
			spawned_bullet.velocity = Vector2(bullet_speed, 0).rotated(global_rotation)
			
			spawned_bullet.bullet_anim(bullet_name)
			
	
		var spawn_capsule = capsule.instantiate()
	
		get_parent().add_child(spawn_capsule)
		var capsule_spawn = $capsule_spawn
		spawn_capsule.position = capsule_spawn.global_position
		
	if weapon_Style == "melee":
		can_attack = false
		animation_weapon.play(weapon_name+"_attack")
		
func reload():
	if ammo < maxAmmo :
		ammo += maxAmmo

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shoot" or anim_name == "shoot-2":
		can_fire = true
		
	if anim_name == weapon_name+"_attack":
		can_attack = true
	
