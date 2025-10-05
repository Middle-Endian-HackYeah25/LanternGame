extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		toggle_object_visibility()
		toggle_door()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("PressurePressers"):
		body._exited_plate();

func toggle_object_visibility() -> void:
	var target_node = get_tree().get_first_node_in_group("firstLight")
	target_node.show()
	
func toggle_door() -> void:
	var target_node = get_tree().get_first_node_in_group("firstDoor")
	target_node.closeDoor()


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
