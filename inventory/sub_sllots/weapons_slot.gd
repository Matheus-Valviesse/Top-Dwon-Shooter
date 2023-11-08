extends TextureRect

var item_index = null
var item_name = null
var item_type = null
var item_texture = null
var item_path = null
var item_status = null

@onready var i_texture = $ItemTexture

func set_item_texture():
		i_texture.set_texture(load(item_texture))

func reset_item():
	i_texture.set_texture(null)
	
	item_index = null
	item_name = null
	item_type = null
	item_texture = null
	item_path = null
	item_status = null
