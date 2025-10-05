extends Node2D

@export var enemy_speed: float = 50.0

var player: CharacterBody2D = null

@onready var sprite: Sprite2D = $Sprite2D 

var current_direction: Vector2 = Vector2.ZERO 
var is_in_light: bool = false

func _ready():
	# Find the player node (already set up)
	player = get_tree().get_first_node_in_group("player")
	if !player:
		print("NoPlayer")
	
	# Crucial: Disable gravity for this body
	add_to_group("LightSensitive")
	
	
func _entered_light():
	print("InLight")
	is_in_light = true; 

func _left_light():
	print("NotInLight")
	is_in_light = false; 

func _integrate_forces(state):
	if is_in_light: 
		current_direction = Vector2.ZERO 
		state.linear_velocity = Vector2.ZERO
	else:
		if player:
			# 1. Calculate the direction vector from the enemy to the player
			current_direction = (player.global_position - global_position).normalized()
		
			# 2. Calculate the desired velocity vector
			var target_velocity: Vector2 = current_direction * enemy_speed
		
			# 3. Directly set the linear velocity on the body's state
			state.linear_velocity = target_velocity
			instant_look_at(state,  player.global_position)
		else:
			current_direction = Vector2.ZERO
			state.linear_velocity = Vector2.ZERO
			player = get_tree().get_first_node_in_group("player")
			if !player:
				print("NoPlayer")
				
func instant_look_at(state: PhysicsDirectBodyState2D, target_position: Vector2) -> void:
	var current_position: Vector2 = state.transform.origin
	var target_dir: Vector2 = (target_position - current_position).normalized()
	var target_angle: float = target_dir.angle()
	var rotation_offset: float = deg_to_rad(180)
	var final_target_angle: float = target_angle + rotation_offset
	
	state.transform = Transform2D(final_target_angle, current_position)
	state.angular_velocity = 0.0
