extends PointLight2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("LightSensitive"):
		body._entered_light();

		
func _on_area_2d_body_exited(body):
	if body.is_in_group("LightSensitive"):
		body._left_light();
