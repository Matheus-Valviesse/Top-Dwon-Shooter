extends CanvasLayer


@onready var inventory = $InventoryContainer

func _process(_delta):
	
	if Input.is_action_just_pressed("inventory"):
	
		if inventory.is_visible == false:
			inventory.is_visible = true
			inventory.animation.play('show')
			return
		
		if inventory.is_visible:
			inventory.is_visible = false
			inventory.animation.play('hide')
			return
		



