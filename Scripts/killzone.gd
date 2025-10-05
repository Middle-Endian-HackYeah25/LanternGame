extends Area2D

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# character dies
	timer.start()
	get_tree().paused = true
	var death_ui = load("res://Scenes/you_died_ui.tscn").instantiate()
	get_tree().root.add_child(death_ui)

func _on_timer_timeout() -> void:
	Inventory.reset_keys()
	get_tree().reload_current_scene()
