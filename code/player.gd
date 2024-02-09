extends CharacterBody2D

const ACCELERATION = 6
const MAX_SPEED = 75

var direction = 0
var previous_direction = Vector2.DOWN

var step_speed = 1

enum STATE {
	idle,
	walk,
	attack
}

func _physics_process(delta):
	if Input.is_action_just_pressed("down"):
		direction = Vector2.DOWN
	if Input.is_action_just_pressed("up"):
		direction = Vector2.UP
	if Input.is_action_just_pressed("right"):
		direction = Vector2.RIGHT
	if Input.is_action_just_pressed("left"):
		direction = Vector2.LEFT
	if !Input.is_action_pressed("left") & !Input.is_action_pressed("right") & !Input.is_action_pressed("up") & !Input.is_action_pressed("down"):
		direction = Vector2.ZERO
	
	velocity = direction.normalized() * MAX_SPEED
	
	#direction = Vector2(horizontal, vertical).normalized()
	
	#velocity = velocity.move_toward(direction*MAX_SPEED*step_speed, ACCELERATION)
	
	#velocity = velocity.normalized()
	
	#$AnimationTree["parameters/BlendSpace2D/blend_position"] = direction
	#$AnimationTree["parameters/BlendSpace2D 2/blend_position"] = direction
	
	#$AnimationTree["parameters/motion/blend_amount"] = int(direction == Vector2.ZERO)
	
	move_and_slide()


func _on_walking_timeout():
	if step_speed == 1:
		step_speed = 0.75
	elif step_speed == 0.75:
		step_speed = 1
