extends CharacterBody2D

const ACCELERATION = 0.5
const MAX_SPEED = 50

func _physics_process(delta):
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	var direction = Vector2(horizontal, vertical)
	
	velocity.x = lerpf(velocity.x, MAX_SPEED*horizontal, ACCELERATION)
	velocity.y = lerpf(velocity.y, MAX_SPEED*vertical, ACCELERATION)
	
	#velocity = velocity.normalized()
	
	$AnimationTree["parameters/BlendSpace2D/blend_position"] = direction
	
	move_and_slide()
