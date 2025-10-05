extends Node2D

@onready var random_timer = $RandomTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var my_toggle_bool: bool = false
var was_turned_on: bool = false 
const MIN_TIME: float = 0.3
const MAX_TIME: float = 0.8

func TurnOn():
	self.show()
	was_turned_on = true
	audio_stream_player_2d.play()
	
func _ready():

	random_timer.one_shot = true
	random_timer.autostart = false
	random_timer.timeout.connect(_on_timer_timeout)
	add_to_group("secondLight")
	start_new_timer() # Begin the cycle

func start_new_timer():
	# randf_range(a, b) returns a random float between a and b
	var random_interval = randf_range(MIN_TIME, MAX_TIME)
	
	random_timer.wait_time = random_interval
	random_timer.start()
	
	# print("New interval set: ", random_interval)

func _on_timer_timeout():
	# Flip the boolean value
	my_toggle_bool = !my_toggle_bool
	if(my_toggle_bool && was_turned_on):
		self.show()
	else:
		self.hide()
	# print("Boolean toggled to: ", my_toggle_bool)
	
	# Restart the process for the next random interval
	start_new_timer()
