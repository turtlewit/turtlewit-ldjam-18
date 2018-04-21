extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var height = 0
export var tile = Vector2(0,0)
export var movescale = 4

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Sprite3D/AnimationPlayer.play("robot_idle")
	global_transform.origin = Vector3(tile[0] * movescale, height, tile[1] * movescale)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
