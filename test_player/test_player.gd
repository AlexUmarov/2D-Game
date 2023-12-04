extends CharacterBody2D
class_name Test_player


@export var speed : float = 60.0
@export var run_speed : float = 3.0
@export var can_double_jump : bool = true
@export var jump_velocity : float = -300.0
@export var double_jump_velocity : float = -300.0
var speed_multiplier : float = 1.0
var has_double_jumped : bool = false
var health = 100
var gold = 0
var isAlive = true
var powerStrikeReady = true
var direction : Vector2 = Vector2.ZERO
@onready var powerStrikeTimer = $Timer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $PlayerStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#velocity.y = jump_velocity
			pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("run"):
		speed_multiplier = run_speed
	else:
		speed_multiplier = 1.0
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	move_and_slide()
	update_animation_parameters()
	update_direction()

func update_animation_parameters():
	if (direction.x == 0):
		animation_tree.set("parameters/Move/blend_position", 0)
	elif (speed_multiplier > 1):
		animation_tree.set("parameters/Move/blend_position", 1)
	else:
		animation_tree.set("parameters/Move/blend_position", 0.5)

func update_direction():
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
