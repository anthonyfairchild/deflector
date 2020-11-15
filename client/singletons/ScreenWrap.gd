extends Node

const _screen_size = Vector2(640, 640)

func wrap(obj, diff_x, diff_y, size = _screen_size):
	if  (obj.position.x < (0 - diff_x)): 
		obj.position.x = size.x
	elif (obj.position.x > (size.x + diff_x)): 
		obj.position.x = 0
	if (obj.position.y < (0 - diff_y)): 
		obj.position.y = size.y
	elif(obj.position.y > (size.y + diff_y)): 
		obj.position.y = 0

func wrap_rigid_body(state):
	var xform = state.get_transform()
	if xform.origin.x > _screen_size.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = _screen_size.x
	if xform.origin.y > _screen_size.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = _screen_size.y
	state.set_transform(xform)
	
