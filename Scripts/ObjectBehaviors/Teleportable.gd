extends Node2D

@export var TPCoords: Array[Vector2]

func _left_light():
	$TeleportationNode.teleport(TPCoords)
	
func _ready() -> void:
	add_to_group("LightSensitive")
