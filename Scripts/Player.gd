extends Camera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var height = 0
export var tile = Vector2(0,0)
export var movescale = 1

var dir = 0 # up right down left



var move = {
	forward = 0,
	right = 0,
	t_left = 0
}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	global_transform.origin = Vector3(tile[0], height, tile[0])

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
	if Input.is_action_just_pressed("move_left"):
		move.right -= 1
	if Input.is_action_just_pressed("move_down"):
		move.forward -= 1
	if Input.is_action_just_pressed("move_right"):
		move.right += 1
	if Input.is_action_just_pressed("turn_left"):
		move.t_left = 1
	if Input.is_action_just_pressed("turn_right"):
		move.t_left = 3
	move(Vector2(move.forward, move.right))
	rotate(move.t_left)
	
	if Input.is_action_just_pressed("fire"):
		fire()

func move(dir):
	var temp1 = transform.basis.z * move.forward
	var temp2 = transform.basis.x * move.right
	var dir2 = Vector2(0,0)
	dir2 += Vector2(temp2.x, temp2.z) 
	dir2 -= Vector2(temp1.x, temp1.z)
	print(dir2)
	tile += dir2
	global_transform.origin = Vector3(tile[0] * movescale, height, tile[1] * movescale)

func rotate(tdir):
	# tdir is either -1 or 1, -1 for right, 1 for left
	dir = (dir + tdir) % 4
	rotation_degrees = Vector3(0, dir * 90, 0)
	print(dir)

func fire():
	pass