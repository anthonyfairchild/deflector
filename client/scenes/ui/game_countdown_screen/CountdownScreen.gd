extends Control

signal finished

onready var _anim = $CanvasLayer/AnimationPlayer

func _ready():
	_anim.play("countdown")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("finished")
