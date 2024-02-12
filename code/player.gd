extends CharacterBody2D

const SPEED = 50

var direction = [Vector2.ZERO]

var can_interact_with_npc = false

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
	
	if $SwordHitbox.has_overlapping_areas():
		var area = $SwordHitbox.get_overlapping_areas()
		print(area)
		if area[0].is_in_group("enemy"):
			area[0].queue_free()
			
	if $AnimationTree.get("parameters/playback").get_current_node() == "ATTACK":
		return
	
	$AnimationTree["parameters/conditions/moving"] = direction[-1] != Vector2.ZERO
	$AnimationTree["parameters/conditions/idle"] = direction[-1] == Vector2.ZERO
	
	$AnimationTree["parameters/RUN/blend_position"] = direction[-1]
	
	if direction[-1] != Vector2.ZERO:
		$AnimationTree["parameters/IDLE/blend_position"] = direction[-1]
		$AnimationTree["parameters/ATTACK/blend_position"] = direction[-1]
		
		if direction[-1] == Vector2.LEFT: $SwordHitbox.rotation_degrees = 270
		if direction[-1] == Vector2.UP: $SwordHitbox.rotation_degrees = 0
		if direction[-1] == Vector2.RIGHT: $SwordHitbox.rotation_degrees = 90
		if direction[-1] == Vector2.DOWN: $SwordHitbox.rotation_degrees = 180
	
	if Input.is_action_just_pressed("attack"):
		$AnimationTree["parameters/conditions/attacking"] = true
		
	move_and_slide()
