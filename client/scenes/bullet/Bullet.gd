class_name Bullet
extends RigidBody2D

export(Texture) var green_bullet_texture
export(Texture) var blue_bullet_texture
export(Texture) var red_bullet_texture
export(Texture) var yellow_bullet_texture
var bullet_color setget _set_bullet_color

onready var _sprite := $Sprite
onready var _player := $AnimationPlayer
onready var _shoot := $Shoot
onready var _bounce := $Bounce

const BULLET_SPEED := 500
const BULLET_LIFETIME_SECONDS := 1

var _velocity: Vector2
var direction:float
var starting_velocity: Vector2
var fired_from

func _ready():
	_set_bullet_color(bullet_color)
	_shoot.play()
	var vdir = Vector2.RIGHT.rotated(direction)
	_velocity = (vdir * BULLET_SPEED) # + starting_velocity
	_player.current_animation = "flying"
	linear_velocity = (vdir * BULLET_SPEED)
	get_tree().create_timer(BULLET_LIFETIME_SECONDS).connect("timeout", self, "_bullet_expiring")

func _integrate_forces(state):
	ScreenWrap.wrap_rigid_body(state)

func _set_bullet_color(color) -> void:
	bullet_color = color
	if _sprite:
		match color:
			Globals.PlayerColor.GREEN:
				_sprite.texture = green_bullet_texture
			Globals.PlayerColor.RED:
				_sprite.texture = red_bullet_texture
			Globals.PlayerColor.YELLOW:
				_sprite.texture = yellow_bullet_texture
			Globals.PlayerColor.BLUE:
				_sprite.texture = blue_bullet_texture
				
func _bullet_expiring():
	_player.current_animation = "exploding"
	_player.connect("animation_finished", self, "_animation_finished")

func _animation_finished(animation):
	if animation == "exploding":
		queue_free()
