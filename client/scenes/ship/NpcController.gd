extends Node2D

export(NodePath) var ship_node_path
export(NodePath) var level_node_path

onready var _ship:Ship = get_node(ship_node_path)
onready var _level:Level = get_node(level_node_path)

func _ready():
	pass # Replace with function body.

