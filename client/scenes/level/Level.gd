class_name Level
extends Node2D


export(PackedScene) var _hazzard_scene

onready var _hazzard_spawn_point = $HazzardSpawnPoint

export(Array, NodePath) var players

onready var _spawn_locations = $SpawnLocations


func _ready():
	var hazzard = _hazzard_scene.instance()
	hazzard.position = _hazzard_spawn_point.position
	call_deferred("add_child", hazzard)
	
	for i in range(players.size()):
		_add_ship(get_node(players[i]), i)

func _add_ship(ship: Ship, i):
	ship.position = _spawn_locations.get_child(i).position
	ship.look_at(_hazzard_spawn_point.position)
	
	
