extends CharacterBody2D

@export var SPEED = 300.0
@export var PUSH_FORCE = 10.0
@export var INTERACT_RANGE = 200.0

@onready var _animated_sprite = $playerSprite

func _physics_process(delta):
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity = direction * SPEED
		_animated_sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0 , SPEED)
		velocity.y = move_toward(velocity.y, 0 , SPEED)
		_animated_sprite.play("idle")
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)

	if Input.is_action_just_pressed("interact"):
		interact()
		

func _process(delta):
	var target_pos = get_global_mouse_position()
	var target_angle = (target_pos - global_position).angle() + deg_to_rad(90)
	var current_angle = rotation

	# Interpolate rotation with easing
	var angle_diff = abs(target_angle - current_angle)
	var speed = lerp(10.0, 3.0, clamp(angle_diff / PI, 0, 1))  # Fast when far, slow when close
	
	rotation = lerp_angle(current_angle, target_angle, speed * delta)
	

func _ready() -> void:
	add_to_group("player")
	
# finds the nearest interactable object, then interacts with it if constraints are met
func interact() -> void:
	var nearest = null
	var min_distance = INF # infinity

	var interactables = get_tree().get_nodes_in_group("interactable")
	for i in interactables:
		var distance = global_position.distance_to(i.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest = i
	if nearest != null and min_distance < INTERACT_RANGE:
		if nearest.has_method("on_interact"):
			nearest.on_interact(self)
