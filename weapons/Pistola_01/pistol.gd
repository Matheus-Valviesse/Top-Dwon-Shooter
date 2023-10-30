extends Weapon

func _ready():
	weapon_texture = "res://weapons/Pistola_01/pistol.png"
	initate()
	
func initate():
	sprite.texture = load(weapon_texture)
	weapon_type = "range"
	weapon_Style = "oneShoot"
	weapon_name = 'pistol'
	bullet_name = 'bolt'
	
	damage = 20
	ammo = 10
	maxAmmo = 10
	bullet_speed = 300
	
func weapon_shoot():
	
	if can_fire:
		
		weapon = pistol
		bulletSpawn = point
		shoot(weapon_Style)



	
	
