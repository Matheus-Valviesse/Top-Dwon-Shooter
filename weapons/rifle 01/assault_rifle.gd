extends Weapon

func _ready():
	weapon_status["weapon_texture"] = "res://weapons/rifle 01/rifle.png"
	initate()

func initate():
	sprite.texture = load(weapon_status["weapon_texture"])
	weapon_status["weapon_type"] = "range"
	weapon_status["weapon_Style"] = "multShoot"
	weapon_status["weapon_name"] = "Rifle"
	weapon_status["bullet_name"] = "spark"
	weapon_status["damage"] = 20
	weapon_status["ammo"] = 10
	weapon_status["maxAmmo"] = 10
	weapon_status["bullet_speed"] = 300

func weapon_shoot():
	if can_fire:
		animation_weapon.speed_scale = 2.8
		bulletSpawn = point
		shoot(weapon_status["weapon_Style"])
