extends RigidBody2D

@export var locked: bool = true 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	if angular_velocity > 1.5 or angular_velocity < -1.5: # 5.0 = small threshold to avoid noise
		if not audio.playing:
			play_random_sound()

func update_lock():
	if locked:
		freeze = true
		$AnimatedSprite2D.frame = 1
	else :
		freeze = false
		$AnimatedSprite2D.frame = 0

func on_interact(player: Node):
	if Inventory.get_key():
		locked = false
		update_lock()
