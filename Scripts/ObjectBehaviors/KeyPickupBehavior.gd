extends Area2D

@export var pickup_sound: AudioStream = null

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	Inventory.add_key(1)
	var s = AudioStreamPlayer2D.new()
	if pickup_sound:
		add_sibling(s)
		s.stream = pickup_sound
		s.play()
	#delete instance
	queue_free()
	await s.finished
	s.free()

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
