extends RigidBody2D

@export var enemy_speed: float = 100.0

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
	gravity_scale = 0.0
	lock_rotation = true
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
		else:
			current_direction = Vector2.ZERO
			state.linear_velocity = Vector2.ZERO
			player = get_tree().get_first_node_in_group("player")
			if !player:
				print("NoPlayer")


func _process(delta):
	# 4. Check if the enemy is moving
	if current_direction.length_squared() > 0:
		# Calculate the target rotation angle in radians
		var target_rotation: float = current_direction.angle()
		
		# Optional: Add a 90 degree offset if your sprite is drawn facing right (0 degrees)
		# If your sprite is drawn facing UP (-90 degrees), you don't need the offset, 
		# or you might need a different offset. Test this!
		var rotation_offset = deg_to_rad(90) 

		# 5. Apply the rotation to the Sprite2D
		sprite.rotation = target_rotation + rotation_offset
