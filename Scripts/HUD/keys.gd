extends HBoxContainer

@export var KeyTexture: Texture2D
@export var IconSize: Vector2 = Vector2(16, 16)

#func _ready() -> void:
	#Inventory.connect("keys_changed", Callable(self, "_on_keys_changed"))
	#_update_icons(Inventory.key_count)
