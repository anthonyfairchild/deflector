extends RigidBody2D

onready var explode_anim := $AnimationPlayer
onready var explosion := $Explosion
export(PackedScene) var hazzard_scene

#var shakeDuration = 0

func _ready():
	explosion.play()
	explode_anim.play("explode")
	yield(explode_anim, "animation_finished")
	var hazzard = hazzard_scene.instance()
	hazzard.global_position = self.global_position
	hazzard.linear_velocity = self.linear_velocity
	get_parent().add_child(hazzard)
	queue_free()

func _integrate_forces(state):
	ScreenWrap.wrap_rigid_body(state)
	
#func _process(delta):
#	if shakeDuration > 1:
#		get_tree().root.get_child(0).set_position(Vector2(randi() % 20 - 10, randi() % 20 - 10))
#		shakeDuration -= 1
#	elif shakeDuration > 0:
#		get_tree().root.get_child(0).set_position(Vector2.ZERO)
#		shakeDuration -= 1
