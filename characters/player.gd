extends CharacterBody3D
@onready var head: Node3D = $head


var curr_speed = 5.0

const walking_speed = 5.0
const sprinting_speed = 8.0
const crouching_speed = 3.0

const JUMP_VELOCITY = 6.5

const mouse_sens = 0.4

var lerp_speed = 10.0

var direction = Vector3.ZERO

var crouching_depth = -0.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x =  clamp(head.rotation.x, deg_to_rad(-89),deg_to_rad(89))
	

	

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("crouch"):
		curr_speed = crouching_speed
		head.position.y = lerp(head.position.y, 1.0 + crouching_depth, delta * lerp_speed)
	else:
		head.position.y = lerp(head.position.y, 1.0, delta * lerp_speed)
		if Input.is_action_pressed("sprint"):
			curr_speed = sprinting_speed
		else:
			curr_speed = walking_speed
			
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta* lerp_speed)
	if direction:
		velocity.x = direction.x * curr_speed
		velocity.z = direction.z * curr_speed
	else:
		velocity.x = move_toward(velocity.x, 0, curr_speed)
		velocity.z = move_toward(velocity.z, 0, curr_speed)

	move_and_slide()
