extends TextureRect
class_name  item


@onready var item_icon = $ItemTexture
@onready var label = $Label

@onready var item_index = get_index()

var item_name : String
var item_texture : String
var item_type : String
var item_info
var item_amount = 0

func _ready():

	item_icon.set_texture(load(item_texture))
	update_item(item_type)
	
func update_item(type):
	if type == 'rune' or type == 'weapon' or type == 'equipament':
		label.set_visible(false)
	else:
		label.set_visible(false)
		label.text = item_amount
		
	
func set_item(name,texture,info,type,amount):
	item_name = name
	item_texture = texture
	item_info = info
	item_type = type
	item_amount = item_amount + amount


