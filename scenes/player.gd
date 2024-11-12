extends CharacterBody2D

class_name Player

@export var speed = 300
var movement_direction = Vector2.ZERO

func _physics_process(delta):
	get_input()
	velocity = movement_direction * speed
	move_and_slide()

func get_input():
	movement_direction = Vector2.ZERO  # Reseta a direção para evitar movimento residual

	if Input.is_action_pressed("left"):
		movement_direction = Vector2.LEFT
		$Sprite2D.scale.x = -1
		rotation_degrees = 0
	elif Input.is_action_pressed("right"):
		movement_direction = Vector2.RIGHT
		$Sprite2D.scale.x = 1
		rotation_degrees = 0
	elif Input.is_action_pressed("up"):
		movement_direction = Vector2.UP
		$Sprite2D.scale.x = 1
		rotation_degrees = 270
	elif Input.is_action_pressed("down"):
		movement_direction = Vector2.DOWN
		$Sprite2D.scale.x = 1
		rotation_degrees = 90

	# Define a velocidade para 0 se não houver movimento
	speed = 0 if movement_direction == Vector2.ZERO else 300
