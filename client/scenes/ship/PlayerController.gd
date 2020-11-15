extends Node2D

export(NodePath) var ship_node_path 

onready var _ship:Ship = get_node(ship_node_path)

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("player_1_ship_rotate_left"):
		_ship.rotate_left()
	if Input.is_action_pressed("player_1_ship_rotate_right"):
		_ship.rotate_right()
	if Input.is_action_pressed("player_1_ship_thrust"):
		_ship.thrust()
	if Input.is_action_just_pressed("player_1_ship_shoot"):
		_ship.fire_bullet()
