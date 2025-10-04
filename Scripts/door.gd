extends RigidBody2D

@export var locked: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_lock()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func update_lock():
	if locked:
		freeze = true
		$AnimatedSprite2D.frame = 1
	else :
		freeze = false
		$AnimatedSprite2D.frame = 0
