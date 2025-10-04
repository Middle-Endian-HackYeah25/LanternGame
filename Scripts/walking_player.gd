extends AudioStreamPlayer2D

func _process(delta: float) -> void:
	var moving := Input.is_action_pressed("left") \
			   or Input.is_action_pressed("right") \
			   or Input.is_action_pressed("up") \
			   or Input.is_action_pressed("down")

	if moving:
		if not playing:
			play()
	else:
		if playing:
			stop()
