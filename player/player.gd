extends CharacterBody2D

var weapon = null
var weapon_status
var equippedWeapon
var arma_instance 

var moveSpeed = 500

@onready var player = $"."

@onready var arm = $Arm
@onready var hand = $Arm/Hand

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func get_input():
	var input_direction = Input.get_vector("left","rigth","up","down")
	velocity = input_direction * moveSpeed
	
