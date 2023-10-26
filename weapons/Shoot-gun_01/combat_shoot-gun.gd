extends Weapon


@onready var pistol = $"."
@onready var point = $Bullet_spawn

func _ready():
	weapon_texture = "res://weapons/Shoot-gun_01/shoot-gun.png"
	initate()
	
func initate():
	sprite.texture = load(weapon_texture)
	weapon_type = "range"
	weapon_Style = "barrageShoot"
	weapon_name = 'shoot_gun'
	bullet_name = "charge"
	
	damage = 20
	ammo = 8
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
	
	
