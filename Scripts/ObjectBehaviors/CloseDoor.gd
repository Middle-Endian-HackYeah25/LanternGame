extends RigidBody2D

@export var locked: bool = true
var is_closing: bool = false

const CLOSED_ANGLE: float = 0.0 # Target angle (0 degrees, facing right/closed)
const CLOSING_SPEED = 10.0      # How fast the door turns back
const STOPPING_THRESHOLD = 0.01 # How close the angle must be to stop
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("firstDoor")
	locked = false
	update_lock()
	add_to_group("interactable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

@onready var audio = $AudioStreamPlayer2D
@export var sounds: Array[AudioStream] = []

func play_random_sound():
	if sounds.is_empty():
		return
	audio.stream = sounds[randi() % sounds.size()]
	audio.play()


func _physics_process(delta: float) -> void:
	if angular_velocity > 1.5 or angular_velocity < -1.5:
		if not audio.playing:
			play_random_sound()

func update_lock():
	if locked:
		print("locking door, ", self)
		freeze = true
		$AnimatedSprite2D.frame = 1
	else :
		print("unlocking door")
		freeze = false
		$AnimatedSprite2D.frame = 0

func on_interact(player: Node):
	print("interacting with ", self.name)
	locked = not locked
	update_lock()
		
func closeDoor():
	print("DoorClosed")
	angular_velocity = 0 
	locked = true
	update_lock()
	is_closing = true
