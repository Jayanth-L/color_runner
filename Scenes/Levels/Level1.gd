extends "res://Scripts/BaseLevel.gd"

export var  tile_number = 10
export var wait_time = 0.5
export var speed = 50

var pallete = [
	Color(244*0.01, 67*0.01, 54*0.01, 2.55),
	Color(233*0.01, 30*0.01, 99*0.01, 2.55),
	Color(156*0.01, 39*0.01, 176*0.01, 2.55),
	Color(103*0.01, 58*0.01, 183*0.01, 2.55),
	Color(33*0.01, 150*0.01, 243*0.01, 2.55),
	Color(0*0.01, 150*0.01, 136*0.01, 2.55),
	Color(76*0.01, 175*0.01, 80*0.01, 2.55),
	Color(255*0.01, 235*0.01, 59*0.01, 2.55),
	Color(255*0.01, 87*0.01, 34*0.01, 2.55),
	Color(121*0.01, 85*0.01, 72*0.01, 2.55),
	Color(96*0.01, 125*0.01, 139*0.01, 2.55)
]

func _physics_process(delta):
	if $RayCast.is_colliding():
		if $RayCast.get_collider().get_parent().material_override.albedo_color in pallete:
			print("Yes")

func _ready():
	randomize()
	set_color_pallete(pallete)
	set_timer_wait_time(wait_time)
	set_tile_speed(speed)
	set_number_of_tilesets(tile_number)
	spawn_tiles(Vector3(0, 0, $Camera.translation.z -200))

