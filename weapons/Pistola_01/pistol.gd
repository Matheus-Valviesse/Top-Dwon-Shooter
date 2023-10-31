extends Weapon

func _ready():
	weapon_status["weapon_texture"] = "res://weapons/Pistola_01/pistol.png"
	initate()

func initate():
	sprite.texture = load(weapon_status["weapon_texture"])
	weapon_status["weapon_type"] = "range"
	weapon_status["weapon_Style"] = "oneShoot"
	weapon_status["weapon_name"] = "pistol"
	weapon_status["bullet_name"] = "bolt"
	weapon_status["damage"] = 20
	weapon_status["ammo"] = 10
	weapon_status["maxAmmo"] = 10
	weapon_status["bullet_speed"] = 300

func weapon_shoot():
	if can_fire:
		weapon = self
		bulletSpawn = point
		shoot(weapon_status["weapon_Style"])
