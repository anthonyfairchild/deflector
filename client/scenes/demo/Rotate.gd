extends Sprite

export(int) var rotation_speed = 1 

func _process(delta):
	rotation += (rotation_speed * delta)
