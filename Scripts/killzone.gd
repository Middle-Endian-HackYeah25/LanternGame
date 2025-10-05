extends Area2D

@onready var timer: Timer = $Timer
var death_ui_img = load("res://Scenes/you_died_ui.tscn")
var death_ui_instance = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# character dies
	if death_ui_instance:
		return
	timer.start()
	get_tree().paused = true
	death_ui_instance = death_ui_img.instantiate()
	get_tree().root.add_child(death_ui_instance)

func _on_timer_timeout() -> void:
	print("killozne timer")
	if death_ui_instance:
		death_ui_instance.queue_free()
		death_ui_instance = null
	Inventory.reset_keys()
	get_tree().paused = false
	get_tree().reload_current_scene()
