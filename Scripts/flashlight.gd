extends PointLight2D

func _ready() -> void:
	add_to_group("light")

func _on_area_2d_body_entered(body):
	if body.is_in_group("LightSensitive"):
		body._entered_light();
		print("InLight")
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("LightSensitive"):
		body._left_light();
		print("NotInLight")


#func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#if area.is_in_group("LightSensitive"):
		#area._entered_light();
		#print("InLight")
#
#
#func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#if area.is_in_group("LightSensitive"):
		#area._left_light();
		#print("notInLight")
