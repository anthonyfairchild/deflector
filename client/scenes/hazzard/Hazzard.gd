class_name Hazzard
extends RigidBody2D

onready var _anim := $AnimationPlayer
onready var _bullet_hit_sound := $BulletHit
onready var _bounce_sound := $Bounce

func _ready():
	add_to_group("hazzards")

func _integrate_forces(state):

	ScreenWrap.wrap_rigid_body(state)

func _on_Hazzard_body_entered(body: RigidBody2D):
	if body && body.get_collision_layer_bit(3): # bullet
		_bullet_hit_sound.play()
		body.queue_free()
	else:
		_bounce_sound.play()

	_anim.play("hit")
