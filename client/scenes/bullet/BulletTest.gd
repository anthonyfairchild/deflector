extends Node2D


export(PackedScene) var bullet_scene
onready var _bullet_spawn_point = $BulletSpawnPoint

func _ready():
	pass # Replace with function body.

func spawn_bullet():
	var bullet:Bullet = bullet_scene.instance()
	bullet.position = _bullet_spawn_point.position
	bullet.direction = Vector2.RIGHT.angle()
	bullet.bullet_color = Bullet.BulletColor.BLUE
	add_child(bullet)


func _on_Timer_timeout():
	spawn_bullet()
