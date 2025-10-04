extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var audio = $AudioStreamPlayer2D
@export var sounds: Array[AudioStream] = []

func play_random_sound():
	if sounds.is_empty():
		return
	audio.stream = sounds[randi() % sounds.size()]
	audio.play()


func _physics_process(delta: float) -> void:
	if linear_velocity.length() > 100.0: # 5.0 = small threshold to avoid noise
		if not audio.playing:
			play_random_sound()
