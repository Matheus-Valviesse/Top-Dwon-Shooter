extends Area2D

@onready var sprite = $Sprite

@export var item_name : String
@export var item_texture : String = "res://assets/Potion/hp potion.png"
@export var item_type : String
@export var item_amount: int = 0
@export var item_status : Array = [
	"",
	"",
	item_amount
]

func _ready():

	update_item()

func update_item():
	sprite.set_texture(load(item_texture))
