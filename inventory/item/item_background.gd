extends TextureRect
class_name  item


@onready var item_icon = $ItemTexture

var item_name
var item_texture
var item_info

func _ready():

	item_icon.set_texture(load(item_texture))




