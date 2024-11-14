extends Area2D

@export var speed = 120
@export var tilemap: TileMap  # Reference to TileMap node
@export var movement_targets: Node  # Reference to node containing scatter targets
@onready var navigation_agent_2d = $NavigationAgent2D

var current_scatter_index = 0

func _ready():
	navigation_agent_2d.path_desired_distance = 4.0
	navigation_agent_2d.target_desired_distance = 4.0
	navigation_agent_2d.target_reached.connect(on_position_reached)
	call_deferred("setup")

func _process(delta):
	if not navigation_agent_2d.is_navigation_finished():
		move_ghost(navigation_agent_2d.get_next_path_position(), delta)

func move_ghost(next_position: Vector2, delta: float):
	var current_ghost_position = global_position
	var new_velocity = (next_position - current_ghost_position).normalized() * speed * delta
	position += new_velocity 

func setup():
	# Make sure tilemap is assigned
	if tilemap:
		var nav_map = tilemap.get_navigation_map(0)
		navigation_agent_2d.set_navigation_map(nav_map)
		NavigationServer2D.agent_set_map(navigation_agent_2d.get_rid(), nav_map)
		scatter()
	else:
		push_error("TileMap reference not set!")

func scatter():
	if movement_targets:
		navigation_agent_2d.target_position = movement_targets.scatter_targets[current_scatter_index].position
	else:
		push_error("Movement targets reference not set!")

func on_position_reached():
	if current_scatter_index < 3:
		current_scatter_index += 1
	else:
		current_scatter_index = 0
	
	scatter()  # Set next target position
