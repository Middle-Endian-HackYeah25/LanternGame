extends HBoxContainer

@export var key_texture: Texture2D
@export var icon_size: Vector2 = Vector2(16, 16)

func _update_icons(count: int) -> void:
	for child in get_children():
		child.queue_free()
		
	for i in range(count):
		# Godot 4 — corrected HUD_Keys.gd snippet
		var tex = TextureRect.new()
		tex.texture = key_texture
		tex.custom_minimum_size = icon_size        # <- use this in Godot 4
		# optional: adjust stretch mode if you want
		tex.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		add_child(tex)

func _on_keys_changed(new_amt: int) -> void:
	_update_icons(new_amt)

func _ready() -> void:
	Inventory.connect("key_amt_changed", Callable(self, "_on_keys_changed"))
	_update_icons(Inventory.key_count)
