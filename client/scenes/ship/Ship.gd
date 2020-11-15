class_name Ship
extends RigidBody2D

signal died

export(PackedScene) var bullet_scene
export(PackedScene) var explosion_scene
export(Globals.PlayerColor) var ship_color

onready var _ship_sprite = $ShipSprite
onready var _animation_player = $AnimationPlayer
onready var _bullet_spawn_point = $BulletSpawnPoint
onready var _thrustSound = $Thrust
onready var _bounce = $Bounce
onready var _shield = $ShieldAnimation

var _previously_collided = false

var _turning_left = false
var _turning_right = false
var _thrusting = false


const _thrust := Vector2.RIGHT * 2500
const _torque := 60000

func _ready():
	_ship_sprite.frame = ship_color
	add_to_group("ships")

func _integrate_forces(state):
	if _thrusting:
		applied_force = _thrust.rotated(rotation)
	else:
		applied_force = Vector2()
	var rotation_dir = 0

	if _turning_right:
		rotation_dir += 1
	if _turning_left:
		rotation_dir -= 1
		
	applied_torque = rotation_dir * _torque
	
	ScreenWrap.wrap_rigid_body(state)

	if _animation_player != null:
		if _thrusting:
			if _turning_left:
				_animation_player.current_animation = "turn_left_forward"
			elif _turning_right:
				_animation_player.current_animation = "turn_right_forward"
			else:
				_animation_player.current_animation = "forward"
		else:
			if _turning_left:
				_animation_player.current_animation = "turn_left"
			elif _turning_right:
				_animation_player.current_animation = "turn_right"
			else:
				_thrustSound.stop()
				_animation_player.current_animation = "idle"

	if _thrustSound != null && (_turning_left || _turning_right || _thrusting) && !_thrustSound.playing:
		_thrustSound.play()

	_turning_left = false
	_turning_right = false
	_thrusting = false


func fire_bullet():
	var bullet: Bullet = bullet_scene.instance()
	bullet.global_position = _bullet_spawn_point.global_position
	bullet.direction = Vector2.RIGHT.rotated(rotation).angle()
	#bullet.starting_velocity = _velocity
	bullet.bullet_color = ship_color
	bullet.fired_from = self
	get_parent().add_child(bullet)

func rotate_left():
	_turning_left = true
	
func rotate_right():
	_turning_right = true
	
func thrust():
	_thrusting = true

func _on_ForwardRay_body_entered(body):
	pass # Replace with function body.

func _on_ForwardRay_body_exited(body):
	pass # Replace with function body.

func _on_Ship_body_entered(body):
	if body && body.get_collision_layer_bit(4): # hazzard
		var explosion = explosion_scene.instance()
		explosion.global_position = self.global_position
		explosion.linear_velocity = self.linear_velocity
		get_parent().call_deferred("add_child", explosion)
		queue_free()
		emit_signal("died")
	else:
		_shield.play("blink")
		_bounce.play()

