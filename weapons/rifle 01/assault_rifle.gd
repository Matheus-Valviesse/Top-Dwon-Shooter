extends Weapon

func _ready():
	weapon_texture = "res://weapons/rifle 01/rifle.png"
	initate()
	
func initate():
	sprite.texture = load(weapon_texture)
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
	
	
