extends AudioStreamPlayer2D

@export var ambient_sounds: Array[AudioStream] = []
@export var min_delay: float = 5.0
@export var max_delay: float = 15.0

var timer: Timer

func _ready():
	timer = $Timer
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	
	finished.connect(_on_audio_finished)
	
	_play_next_sound()

func _play_next_sound():
	if ambient_sounds.size() == 0:
		return
	
	# Pick a random sound
	var sound = ambient_sounds[randi() % ambient_sounds.size()]
	stream = sound
	play()

func _on_timer_timeout():
	_play_next_sound()
	
func _on_audio_finished():
	var delay = randf_range(min_delay, max_delay)
	timer.start(delay)
