extends CharacterBody2D

const SPEED = 75

var direction = [Vector2.ZERO]

func _physics_process(delta):
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if Input.is_action_just_pressed("down"):
		direction.append(Vector2.DOWN)
	if Input.is_action_just_pressed("up"):
		direction.append(Vector2.UP)
	if Input.is_action_just_pressed("right"):
		direction.append(Vector2.RIGHT)
	if Input.is_action_just_pressed("left"):
		direction.append(Vector2.LEFT)
		
	if Input.is_action_just_released("down"):
		direction.erase(Vector2.DOWN)
	if Input.is_action_just_released("up"):
		direction.erase(Vector2.UP)
	if Input.is_action_just_released("right"):
		direction.erase(Vector2.RIGHT)
	if Input.is_action_just_released("left"):
		direction.erase(Vector2.LEFT)
		
	velocity = direction[-1] * SPEED
	
	$AnimationTree["parameters/conditions/moving"] = direction[-1] != Vector2.ZERO
	$AnimationTree["parameters/conditions/idle"] = direction[-1] == Vector2.ZERO
	
	$AnimationTree["parameters/RUN/blend_position"] = direction[-1]
	$AnimationTree["parameters/IDLE/blend_position"] = direction[-1]
	
	move_and_slide()
