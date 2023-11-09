extends Area2D

var velocity = Vector2.ZERO

@onready var bullet = $"."
@onready var animation_bullet = $AnimationPlayer

func _physics_process(delta):
	position +=  velocity * delta 

func bullet_anim(name):
	animation_bullet.play(name)


func _on_body_entered(body):
#	if body.name == "TileMap":
#		var impact_scene = preload("res://bullets/Bullet_impact/Impact.tscn")
#		var impact_instance = impact_scene.instantiate()
#		get_parent().add_child(impact_instance)
#		impact_instance.global_position = bullet.global_position
#		impact_instance.set_impact_anim(animation_bullet.current_animation)
#		bullet.queue_free()
	pass		
		
		
		
