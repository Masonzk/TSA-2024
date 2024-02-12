extends Area2D

var directions = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]

var direction = Vector2.ZERO
var angle_to = 0
@onready var current_position = position

func _ready():
	_on_timer_timeout()
	
func _process(delta):
	$RayCast2D.position = position
	rotation = move_toward(rotation, angle_to, 0.5)
	position = position.move_toward(current_position+direction*16, 0.25)
	
	if position.is_equal_approx(current_position+direction*16):
		$AnimationPlayer.play("idle")
		
func _on_timer_timeout():
	current_position = position
	direction = directions[randi_range(0, 3)]
	
	$RayCast2D.target_position = direction*16
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding():
		print($RayCast2D.get_collider())
		if $RayCast2D.get_collider().is_in_group("border"):
			_on_timer_timeout()
			return
	
	angle_to = position.angle_to_point(position + direction)
	
	$Timer.start(randf_range(1, 3))
	
	$AnimationPlayer.play("move")
