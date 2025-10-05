extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("boxes"): 
		toggle_object_visibility()
		
		
		
func toggle_object_visibility() -> void:
	for node in get_tree().get_nodes_in_group("secondLight"): 
		node.TurnOn()


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
