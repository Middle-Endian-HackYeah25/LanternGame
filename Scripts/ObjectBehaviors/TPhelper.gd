extends Node2D

@export var TPCoords: Array[Vector2]

func _ready() -> void:
	$RigidBody2D.TPCoords = TPCoords
