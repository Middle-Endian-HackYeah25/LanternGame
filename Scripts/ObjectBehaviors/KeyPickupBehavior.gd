extends Area2D

@export var pickup_sound: AudioStream = null

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	Inventory.add_key(1)
	if pickup_sound:
		var s = AudioStreamPlayer2D.new()
		s.stream = pickup_sound
		add_child(s)
		s.play()
	#delete instance
	queue_free()

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
