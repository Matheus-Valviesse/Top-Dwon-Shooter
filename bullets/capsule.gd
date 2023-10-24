extends RigidBody2D

@onready var capsule = $"."
@onready var timer = $Timer
@onready var sprite = $Capsule_Sprite
@onready var animation = $Animation

var rand_jump = randf_range(-165, -180)
var direction = 0
var rand_timer = randf_range(0.76, 0.82)
var actual_y
var bounce = false
var jump_max_count
var jump_count = 1
var binit = true

func _init():
	set_direction()
	jump_max_count = randi_range(2,3)

func _physics_process(delta):
	
	if capsule.linear_velocity.y > 400:
		capsule.linear_velocity.y = 400
	
	if bounce == true and capsule.global_position.y >= actual_y and jump_count <= jump_max_count:
		set_bounce()
		
	if jump_count > jump_max_count :
		capsule.gravity_scale = 0
		self.linear_velocity = Vector2.ZERO
		animation.play("alpha")
		
	if jump_count <= jump_max_count:
		sprite.rotate(direction * 10 * delta)
		capsule.linear_velocity.x += (direction / 0.95)
		
	if binit == true:
		print(get_parent().get_node("Player").global_position.y)
		actual_y = get_parent().get_node("Player").global_position.y
		capsule.apply_impulse(Vector2(0, rand_jump))
		timer.wait_time = rand_timer
		timer.start()
		binit = false

func _on_timer_timeout():
	actual_y = capsule.position.y
	bounce = true

func set_bounce():
		
		jump_count += 1
		capsule.linear_velocity.y = 0
		capsule.linear_velocity.y = rand_jump * 1.2
		bounce = false
		call_bounce()

func call_bounce():
	set_direction()
	await get_tree().create_timer(0.55).timeout
	bounce = true

func set_direction():
	var set_direction = randf_range(0.11,0.61)
	if randi() % 2 == 1:
		direction = set_direction
	else:
		direction = set_direction *  -1

func _on_animation_animation_finished(anim_name):
	if anim_name == "alpha":
		queue_free()
