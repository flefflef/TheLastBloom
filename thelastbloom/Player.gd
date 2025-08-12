extends CharacterBody2D

@export var speed := 400
@export var acceleration := 3	
@export var health = 10
@export var damage = 3

const gravity = 20
const min_jump_height = -150
const max_jump_height = -350
var timeHeld = 0
var TimeHeldFullJump = 1
var motion = Vector2()

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed 
	
	
func _physics_process(_delta: float) -> void:
	var old_velocity = velocity
	get_input()
	velocity = old_velocity.move_toward(velocity, acceleration * speed * _delta	)
	
	
	motion.y += gravity
	var friction = false
	if is_on_floor():
		if Input.is_action_pressed("up"):
			timeHeld += _delta
			if timeHeld >= TimeHeldFullJump:
				motion.y = max_jump_height
			if Input.is_action_just_released("up"):
				motion.y = ((max_jump_height - min_jump_height) * (timeHeld / TimeHeldFullJump) + min_jump_height)
				
				
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
	move_and_slide()	
