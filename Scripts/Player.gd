extends KinematicBody

export var maxSpeed = 100
export var acceleration = 1
export var decay = 0.01
export var jumpPower = 10
export var gravity = 9.8
onready var gravityVector = Vector3.DOWN * gravity
export var rotSpeed = 0.1

var velocity = Vector3()
onready var collected = 0
export var winCondition = 100



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	#print(velocity.length())
	velocity += gravityVector * delta
	player_movement()
	velocity = move_and_slide(velocity, Vector3.UP)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		print("moving Mouse")
		rotate_y(-lerp(0, rotSpeed, event.relative.x/10))

func player_movement():
	var moved = false
	var newVelocity = velocity
	newVelocity.y = 0
	if Input.is_action_pressed("ui_up"):
		newVelocity += -transform.basis.z * acceleration
		moved = true
	if Input.is_action_pressed("ui_down"):
		newVelocity += transform.basis.z * acceleration
		moved = true
	if Input.is_action_pressed("ui_left"):
		newVelocity += -transform.basis.x * acceleration
		moved = true
	if Input.is_action_pressed("ui_right"):
		newVelocity += transform.basis.x * acceleration
		moved = true

	if newVelocity.length() > maxSpeed:
		newVelocity = newVelocity.normalized()*maxSpeed
		
	if Input.is_action_pressed("ui_accept") && is_on_floor():
		print("Jump")
		newVelocity.y = jumpPower
		moved = true
	else:
		newVelocity.y = velocity.y
	if !moved:
		newVelocity = newVelocity * (1-decay)
	velocity = newVelocity


