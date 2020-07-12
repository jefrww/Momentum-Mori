extends KinematicBody

export var maxSpeed = 100
export var acceleration = 1
export var decay = 0.01
export var jumpPower = 10
export var gravity = 9.8
onready var gravityVector = Vector3.DOWN * gravity
export var rotSpeed = 0.1
export(NodePath) var pathToSFX
export(AudioStream) var jump
export(AudioStream) var coin

var velocity = Vector3()
onready var collected = 0
export var winCondition = 100
onready var soundPlayer = get_node(pathToSFX) 

var jumping = false
var jumpduration = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _process(delta):
	updateAnim()
	if jumping:
		jumpduration += delta
		print(jumpduration)
		if jumpduration >= 1:
			get_child(2).get_child(2).set("parameters/Jump/active", false)
			jumping = false
			jumpduration = 0

func updateAnim():
	var choppedVel = Vector2(velocity.x, velocity.z)
	var choppedForward = Vector2(transform.basis.z.x, transform.basis.z.z)
	var angle = choppedForward.angle_to(choppedVel)
	get_child(2).get_child(2).set("parameters/WASDmovement/blend_position", (Vector2(1,0)*((choppedVel.length()*2)/maxSpeed)).rotated(angle).rotated(PI*1.5).reflect(Vector2(0,1)))
	

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
		rotate_y(-lerp(0, rotSpeed, event.relative.x/10))

func _play_jump_sound():
	soundPlayer.stream = jump
	soundPlayer.play(0.0)
	
func _play_coin_sound():
	soundPlayer.stream = coin
	soundPlayer.play(0.0)	

func player_movement():
	var moved = false
	var newVelocity = velocity
	newVelocity.y = 0
	if Input.is_action_pressed("ui_up") && is_on_floor():
		newVelocity += -transform.basis.z * acceleration
		moved = true
	if Input.is_action_pressed("ui_down") && is_on_floor():
		newVelocity += transform.basis.z * acceleration
		moved = true
	if Input.is_action_pressed("ui_left") && is_on_floor():
		newVelocity += -transform.basis.x * acceleration
		moved = true
	if Input.is_action_pressed("ui_right") && is_on_floor():
		newVelocity += transform.basis.x * acceleration
		moved = true

	if newVelocity.length() > maxSpeed:
		newVelocity = newVelocity.normalized()*maxSpeed
		
	if Input.is_action_pressed("ui_accept") && is_on_floor():
		print("Jump")
		get_child(2).get_child(2).set("parameters/Jump/active", true)
		_play_jump_sound()
		newVelocity.y = jumpPower
		moved = true
		jumping = true
	else:
		newVelocity.y = velocity.y
	if !moved:
		newVelocity = newVelocity * (1-decay)
	velocity = newVelocity


