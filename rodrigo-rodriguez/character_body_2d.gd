extends CharacterBody2D


var SPEED = 10
const BASESPEED = 10
const ACCEL = 20
const DECCEL = 50 #Deacceleration
const MAXSPEED = 1500
const JUMP_VELOCITY = -400.0
const STOMP_POWER = -1000.0
var JUMPS = 2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	handlejump()
	
	handleStomp()
	
	handleMovement()

	move_and_slide()


func handlejump():
	if Input.is_action_just_pressed("ui_accept") and JUMPS != 0:
		velocity.y = JUMP_VELOCITY
		JUMPS -= 1
	else:
		if is_on_floor():
			JUMPS = 2

func handleMovement():
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0: 
		velocity.x = move_toward(velocity.x, direction * MAXSPEED, ACCEL)
		
	else:
		velocity.x = move_toward(velocity.x, 0, DECCEL)
		

func handleStomp():
	if Input.is_action_just_pressed("ui_down") and not is_on_floor():
		velocity.y -= STOMP_POWER
