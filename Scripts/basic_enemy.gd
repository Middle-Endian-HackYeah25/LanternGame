extends Node2D


@export var enemy_speed: float = 50.0

@export var TPCoords: Array[Vector2]


var player: CharacterBody2D = null

@onready var sprite: Sprite2D = $Sprite2D 

var current_direction: Vector2 = Vector2.ZERO 
var is_in_light: bool = false

# --- State machine variables for teleportation ---
var is_teleporting: bool = false
var teleport_requested: bool = false
var teleport_destination: Vector2 = Vector2.ZERO
var teleport_delay_timer: float = 0.0
# ---

func _ready():
	# Find the player node (already set up)
	player = get_tree().get_first_node_in_group("player")
	
	# Crucial: Disable gravity for this body
	add_to_group("LightSensitive")
	
	
func _entered_light():
	is_in_light = true; 

# --- This function now only REQUESTS a teleport ---
func _left_light():
	is_in_light = false
	if !TPCoords.is_empty():
		teleport_destination = TPCoords[randi() % TPCoords.size()]
		teleport_requested = true

# --- All physics logic is now safely inside _integrate_forces ---
func _integrate_forces(state: PhysicsDirectBodyState2D):
	# State 1: Teleportation is requested
	if teleport_requested:
		state.transform.origin = teleport_destination
		teleport_requested = false
		is_teleporting = true
		teleport_delay_timer = 1.0 # The delay duration from your last version
		state.linear_velocity = Vector2.ZERO
		return

	# State 2: Currently in post-teleport delay
	if is_teleporting:
		teleport_delay_timer -= state.step # state.step is delta time
		state.linear_velocity = Vector2.ZERO
		if teleport_delay_timer <= 0:
			is_teleporting = false
		return

	# State 3: Currently in light
	if is_in_light: 
		state.linear_velocity = Vector2.ZERO
		return

	# State 4: Normal movement
	if player:
		current_direction = (player.global_position - global_position).normalized()
		var target_velocity: Vector2 = current_direction * enemy_speed
		state.linear_velocity = target_velocity
		instant_look_at(state,  player.position)
	else:
		# Try to find player again if it was null
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
