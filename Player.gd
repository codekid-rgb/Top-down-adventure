extends KinematicBody2D

# Top speed (this fast, no faster)
const MAX_SPEED = 500

# Control rate at which player gets up to speed
const ACCELERATION = 1000

# Control rate at which player goes to zero
const FRICTION = 3000

# Remaining velocity during slides and glides
var velocity = Vector2.ZERO

# Nodes we'll need to use a lot
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


func _physics_process(delta: float) -> void:
	# Compute the desired direction from the gamepad or keyboard inputs
	var input_direction := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	# We want to be consistent for all directions, so normalize
	input_direction = input_direction.normalized()

	# compute whether we're going or stopping
	if input_direction == Vector2.ZERO:
		# switch to idle animation, we don't want to change direction (blend_position) though
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		# Switch animation to running state (blend_position will take care of direction)
		animationState.travel("run")

		# Rotate the input 45 degrees so that up and down get a run animation too
		var rotated = input_direction.rotated(PI / 4.0).x + input_direction.rotated(-PI / 4.0).x
		animationTree.set("parameters/run/blend_position", rotated)
		animationTree.set("parameters/idle/blend_position", rotated)
		velocity = velocity.move_toward(input_direction * MAX_SPEED, ACCELERATION * delta)
	#checking for the sword button
	if Input.is_action_pressed("sword"):
		animationState.travel("Sword")
	# Move and slide the character taking into account collsions
	velocity = move_and_slide(velocity)
