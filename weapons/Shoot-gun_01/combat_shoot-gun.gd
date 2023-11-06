extends Weapon

func _ready():
	weapon_status["weapon_texture"] = "res://weapons/Shoot-gun_01/shoot-gun.png"
	initate()
	
func initate():
	
	sprite.texture = load(weapon_status["weapon_texture"])
	weapon_status["weapon_type"] = "range"
	weapon_status["weapon_Style"]= "barrageShoot"
	weapon_status["weapon_name"]= 'shoot_gun'
	weapon_status["bullet_name"]= "charge"
	weapon_status["damage"] = 20
	weapon_status["ammo"] = 8
	weapon_status["maxAmmo"] = 10
	weapon_status["bullet_speed"] = 300
	
func weapon_shoot():
	
	if can_fire:
		
		bulletSpawn = point
		shoot(weapon_status["weapon_Style"])

	
	
