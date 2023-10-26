extends Weapon


@onready var pistol = $"."
@onready var point = $Bullet_spawn

func _ready():
	weapon_texture = "res://weapons/Rifle_01/rifle.png"
	initate()
	
func initate():
	weapon_type = "range"
	weapon_Style = "multShoot"
	weapon_name = 'Rifle'
	bullet_name = "spark"
	
	damage = 20
	ammo = 10
	maxAmmo = 10
	bullet_speed = 300
	
func weapon_shoot():
	
	if can_fire:
		
		weapon = pistol
		bulletSpawn = point
		shoot(weapon_Style)


func create_weapon(damage,ammo,maxAmmo):
	
	damage = damage
	ammo = ammo
	maxAmmo = maxAmmo
	
	