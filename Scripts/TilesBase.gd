extends Spatial

export var tile_speed = 10

func _ready():
	pass

func _process(delta):
	translation.z += tile_speed*delta

func _on_VisibilityNotifier_screen_exited():
	print("queing free")
	queue_free()
