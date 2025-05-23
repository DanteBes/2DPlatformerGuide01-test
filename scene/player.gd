extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var plaerSprite = $Sprite2D 

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("step_top") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("step_left", "step_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if velocity.x < 0:
		plaerSprite.flip_h = false
	if velocity.x > 0:
		plaerSprite.flip_h = true
	
	if velocity.x != 0 && is_on_floor():
		plaerSprite.animation = "run"
	else:
		plaerSprite.animation ="idle"
	if not is_on_floor():
		plaerSprite.animation = "jump"
