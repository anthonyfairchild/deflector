extends Node2D

signal game_over(winning_ship)
signal game_paused

onready var _player_ship = $Level/PlayerShip
onready var _music = $Music

func _ready():
	pass

func start_game():
	_music.play()

func _on_Level_game_over(winning_ship):
	emit_signal("game_over", winning_ship)

func _on_PlayerShip_died():
	emit_signal("game_over", _player_ship)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("game_paused")
