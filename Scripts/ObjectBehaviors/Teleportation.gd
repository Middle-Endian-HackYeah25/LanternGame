extends Node2D


var skip_point = false

func isPointDark(point: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state

	var query = PhysicsPointQueryParameters2D.new()
	query.position = point
	query.collide_with_bodies = true
	query.collide_with_areas = true

	var result = space_state.intersect_point(query)
	print("Check result ", result)

	if not result.is_empty():
		for hit in result:
			var collider_node = hit.collider
			if collider_node.is_in_group("light"):
				return false
	return true

func teleport(TPCoords: Array[Vector2]) -> void:
	print("teleporting...")
	if TPCoords.size() > 0:
		var valid_coords: Array[Vector2] = []

		for point in TPCoords:
			if isPointDark(point):
				valid_coords.append(point)

		if valid_coords.size() > 0:
			var random_point = valid_coords.pick_random()
			print("teleporting to ", random_point)
			get_parent().global_position = random_point
