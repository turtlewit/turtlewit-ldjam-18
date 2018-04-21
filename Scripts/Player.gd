extends Camera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var height = 0
export var tile = Vector2(0,0)
export var movescale = 1

var move_colliders
var collider_names

var dir = 0 # up right down left

var move = {
	forward = 0,
	right = 0,
	t_left = 0
}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	global_transform.origin = Vector3(tile[0] * movescale, height, tile[1] * movescale)
	move_colliders = {
		east 	= $ColliderEast,
		west 	= $ColliderWest,
		north 	= $ColliderNorth,
		south 	= $ColliderSouth
	}
	collider_names = [
		move_colliders.east.name, 
		move_colliders.west.name, 
		move_colliders.north.name, 
		move_colliders.south.name
	]

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	process_input()

func process_input():
	move.forward = 0
	move.right = 0
	move.t_left = 0
	if Input.is_action_just_pressed("move_up"):
		move.forward += 1
	elif Input.is_action_just_pressed("move_left"):
		move.right -= 1
	elif Input.is_action_just_pressed("move_down"):
		move.forward -= 1
	elif Input.is_action_just_pressed("move_right"):
		move.right += 1
	if Input.is_action_just_pressed("turn_left"):
		move.t_left = 1
	if Input.is_action_just_pressed("turn_right"):
		move.t_left = 3
	if move.forward != 0 or move.right != 0:
		move(Vector2(move.right, move.forward))
	rotate(move.t_left)
	
	if Input.is_action_just_pressed("fire"):
		fire()

func move(dir):
	var temp1 = transform.basis.z * move.forward
	var temp2 = transform.basis.x * move.right
	var dir2 = Vector2(0,0)
	dir2 += Vector2(temp2.x, temp2.z) 
	dir2 -= Vector2(temp1.x, temp1.z)
	print(dir)
	if is_move_good(dir):
		tile += dir2
		tile.x = int(round(tile.x))
		tile.y = int(round(tile.y))
		print(tile, "\n")
		global_transform.origin = Vector3(tile[0] * movescale, height, tile[1] * movescale)

func rotate(tdir):
	# tdir is either -1 or 1, -1 for right, 1 for left
	dir = (dir + tdir) % 4
	rotation_degrees = Vector3(0, dir * 90, 0)

func fire():
	pass

#func is_move_good(dir):
#	var from = global_transform.origin
#	var to = from + Vector3(dir[0] * (movescale + 1), 0, dir[1] * (movescale + 1)) 
#	var space_state = get_world().get_direct_space_state()
#	#print (from, to)
#	var result = space_state.intersect_ray(from, to, []) # Include self here
#	if not result.empty():
#		if result.collider.name != "enemy":
##			var distance = abs((camera.global_transform.origin - (result.collider.translation + Vector3(0,1,0) * camera.global_transform.origin.y)).length())
##			result.collider.on_hit(1, 10 * (ray_length / distance))
#			return false
#	return true

func is_move_good(dir2):
	var collided = []
	if int(round(dir2.x)) == -1:
		print("west")
		collided += move_colliders.west.get_overlapping_bodies()
	if int(round(dir2.x)) == 1:
		print("east")
		collided += move_colliders.east.get_overlapping_bodies()
	if int(round(dir2.y)) == 1:
		print("north")
		collided += move_colliders.north.get_overlapping_bodies()
	if int(round(dir2.y)) == -1:
		print("south")
		collided += move_colliders.south.get_overlapping_bodies()
	
	if not collided.empty():
		for collider in collided:
			print (collider.name)
			if not collider.name in collider_names:
				return false
	return true
	

func _on_ColliderWest_area_entered(area):
	print("AAAAAAAAAAAAAAAAAAAAAAHIOTYASDAHGUIOADSGINADGDSAUIOGADSGASNDIFUDSAF")


func _on_ColliderWest_body_entered(body):
	print("AAAAAAAAAAAAAAAAAAAAAAHIOTYASDAHGUIOADSGINADGDSAUIOGADSGASNDIFUDSAF")


func _on_ColliderWest_area_shape_entered(area_id, area, area_shape, self_shape):
	print("AAAAAAAAAAAAAAAAAAAAAAHIOTYASDAHGUIOADSGINADGDSAUIOGADSGASNDIFUDSAF")


func _on_ColliderWest_body_shape_entered(body_id, body, body_shape, area_shape):
	print("AAAAAAAAAAAAAAAAAAAAAAHIOTYASDAHGUIOADSGINADGDSAUIOGADSGASNDIFUDSAF")
