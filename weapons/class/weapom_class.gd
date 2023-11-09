extends Area2D

class_name Weapon

var Bullet = preload("res://bullet/Bullet.tscn")
var capsule = preload("res://bullet/capsule.tscn")

@onready var weapon = $"."
@onready var bulletSpawn = $Bullet_spawn

@onready var sprite = $Sprite
@onready var animation_weapon = $Animation
@onready var point = $Bullet_spawn
@onready var capsule_spawn = $Capsule_spawn

var can_fire = true
var can_attack = true

var weapon_status = {
	"name":"",
	"damage": 0,
	"ammo": 0,
	"maxAmmo": 0,
	"reload-time": 0.0,
	"bullet-speed": 0,
	"bullet_name": "",
	"style": "",
	"texture": "",
	"type": "weapon",
	"weapon_type": "",
	"weapon_name": "",
	
}

func _process(_delta):
	
	if weapon_status["type"] == "melee" and can_attack == true:
		animation_weapon.play(weapon_status["weapon_name"] + "_idle")
		
func shoot(type):
	if weapon_status["ammo"] > 0 :
		can_fire = false
		weapon_status["ammo"] -= 1
		
		if weapon_status["style"] == "multShoot":
			animation_weapon.play("shoot-2")
		else:	
			animation_weapon.play("shoot")
			
		if weapon_status["weapon_Style"] == "barrageShoot":
			var num_projeteis = 8
	
			for i in range(num_projeteis):
				var spawned_bullet = Bullet.instantiate()
				get_parent().add_child(spawned_bullet)
				var random_angle = deg_to_rad(randf_range(-45, 45))  # Intervalo de -30 a 30 graus
				var random_speed = randf_range(weapon_status["bullet-speed"] - 50, weapon_status["bullet-speed"] + 50)  # Intervalo de -50 a 50 da velocidade padrão
				spawned_bullet.rotation = global_rotation + random_angle
				spawned_bullet.position = bulletSpawn.global_position
				spawned_bullet.velocity = Vector2(weapon_status["bullet_speed"] + random_speed, 0).rotated(global_rotation + random_angle)   
				spawned_bullet.bullet_anim(weapon_status["bullet_name"])
		else:
			var spawned_bullet = Bullet.instantiate()
			get_parent().add_child(spawned_bullet)
			spawned_bullet.rotation = weapon.global_rotation
			spawned_bullet.position = bulletSpawn.global_position
			spawned_bullet.velocity = Vector2(weapon_status["bullet_speed"], 0).rotated(global_rotation)
			
			spawned_bullet.bullet_anim(weapon_status["bullet_name"])
			
	
		var spawn_capsule = capsule.instantiate()
		
		get_parent().add_child(spawn_capsule)
		spawn_capsule.position = capsule_spawn.global_position
		
	if weapon_status["style"] == "melee":
		can_attack = false
		animation_weapon.play(weapon_status["weapon_name"]+"_attack")
		
func reload():
	if weapon_status["ammo"] < weapon_status["maxAmmo"] :
		weapon_status["ammo"] += weapon_status["maxAmmo"]

func _on_animation_finished(anim_name):
	if anim_name == "shoot" or anim_name == "shoot-2":
		can_fire = true
		
	if anim_name == weapon_status["weapon_name"]+"_attack":
		can_attack = true
	
