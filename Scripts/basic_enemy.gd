extends RigidBody2D

# The speed value used to set the magnitude of the velocity vector.
@export var speed: float = 150.0

# Define the constant, normalized direction vector for the enemy.
# This example moves the enemy straight to the right.
# You can change this vector (e.g., Vector2(-1, 0) for left, or Vector2(0.5, 1).normalized() for diagonal)
const CONSTANT_DIRECTION: Vector2 = Vector2(1, 0)

# -----------------
# Physics Setup
# -----------------

func _ready():
	# 1. Ensure the enemy is not affected by global gravity.
	gravity_scale = 0.0
	
	# 2. Prevent the enemy from rotating when it collides with something.
	lock_rotation = true
	
	# Initial impulse is removed, as continuous velocity control is handled below.

# -----------------
# Constant Velocity Movement
# -----------------

# We override the physics process to constantly reset the velocity to our desired value.
func _physics_process(delta: float) -> void:
	# Calculate the target velocity vector (Direction * Speed).
	var target_velocity: Vector2 = CONSTANT_DIRECTION * speed
	
	# Set the linear_velocity directly. 
	# This overrides any forces (like friction or gravity, though gravity is already 0)
	# and makes the movement constant and predictable.
	linear_velocity = target_velocity

# The move_with_force function is no longer needed since we are not applying forces.
# func move_with_force(direction: Vector2):
# 	pass
