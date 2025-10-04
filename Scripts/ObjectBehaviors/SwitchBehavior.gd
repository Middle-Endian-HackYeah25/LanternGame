extends Node

@export var powered_object: Node
@export var off_sprite: Texture2D
@export var on_sprite: Texture2D

var off: bool = true

func on_interact(player: Node):
	if powered_object.has_method("change_state"):
		powered_object.change_state
	
	if off:
		off = false
		$Sprite2D.Texture = on_sprite
	else:
		off = true
		$Sprite2D.Texture = off_sprite

func _ready() -> void:
	$Sprite2D.Texture = off_sprite
	add_to_group("interactable")
