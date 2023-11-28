extends CharacterBody2D

@onready var boolet = preload("res://bullet.tscn")

var gravity = 980
const JUMP_VELOCITY = -200
const SPEED = 200

func _input(event):
	if event.is_action_pressed("shoot"):
		var bullet = boolet.instantiate()
		bullet.position = position
		get_parent().add_child(bullet)
		bullet.get_node("Timer").start()
		bullet.apply_impulse(Vector2(Input.get_axis("left", "right")*500, -500))
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle falp.
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

