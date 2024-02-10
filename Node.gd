extends Node2D

const TILE_SIZE = 20
const GRID_SIZE = Vector2(30, 20)

var snake = []
var direction = Vector2.RIGHT
var food_position = Vector2()

func _ready():
	generate_food()
	snake.append(Vector2(5, 5)) # Initial snake position
	snake.append(Vector2(4, 5))
	snake.append(Vector2(3, 5))

func _process(delta):
	if Input.is_action_just_pressed("ui_right") and direction != Vector2.LEFT:
		direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("ui_left") and direction != Vector2.RIGHT:
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_up") and direction != Vector2.DOWN:
		direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down") and direction != Vector2.UP:
		direction = Vector2.DOWN

	move_snake()

func move_snake():
	var new_head = snake[0] + direction

	if new_head.x < 0 or new_head.y < 0 or new_head.x >= GRID_SIZE.x or new_head.y >= GRID_SIZE.y or new_head in snake:
		# Game Over
		print("Game Over")
		get_tree().quit()
		return

	snake.insert(0, new_head)

	if new_head == food_position:
		generate_food()
	else:
		snake.pop_back()

func generate_food():
	food_position = Vector2(randi() % int(GRID_SIZE.x), randi() % int(GRID_SIZE.y))

func _draw():
	var canvas_item = get_tree().get_canvas_item()
	canvas_item.draw_rect(Rect2(0, 0, GRID_SIZE.x * TILE_SIZE, GRID_SIZE.y * TILE_SIZE), Color(0.1, 0.1, 0.1))

	for segment in snake:
		canvas_item.draw_rect(Rect2(segment.x * TILE_SIZE, segment.y * TILE_SIZE, TILE_SIZE, TILE_SIZE), Color(0.8, 0.8, 0.8))

	canvas_item.draw_rect(Rect2(food_position.x * TILE_SIZE, food_position.y * TILE_SIZE, TILE_SIZE, TILE_SIZE), Color(0.8, 0.2, 0.2))
