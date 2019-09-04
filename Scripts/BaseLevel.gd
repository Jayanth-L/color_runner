extends Spatial

var tiles_position_distance = 15.935
var current_player_position_sum = 0

var tiles_number
var timer_wait_time
var tile_speed

var tile_base = preload("res://Scenes/TilesBase.tscn")
onready var player_tween = get_node("Player/Tween")

var color_pallete = []


var camera_angle = 0
var mouse_sensitivity = 0.1
var camera_change = Vector2()



#walk variables
const MAX_SPEED = 20
const MAX_RUNNING_SPEED = 30
const ACCEL = 2
const DEACCEL = 6

#slope variables
const MAX_SLOPE_ANGLE = 35

#stair variables
const MAX_STAIR_SLOPE = 20
const STAIR_JUMP_HEIGHT = 6

const VELOCITY_RATIO = 30

func lock_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	# aim()
	#$Camera.translation.z += -camera_speed*delta
	
	if Input.is_mouse_button_pressed(1):
		# print("Should Jump but commented.")
		pass
	
func _input(event):
	if event is InputEventMouseMotion:
 		camera_change = event.relative

func aim():
        if camera_change.length() > 0:
                $Player.rotate_y(deg2rad(camera_change.x * mouse_sensitivity))

                var change = -camera_change.y * mouse_sensitivity
                if change + camera_angle < 90 and change + camera_angle > -90:
                        #$Camera2.rotate(transform.basis.x, deg2rad(-change))
                        camera_angle += change
                camera_change = Vector2()


func spawn_tiles(position):
	
	
	var count = 0
	while count < tiles_number:
		var first_color = int(rand_range(0, 11))
		var second_color = int(rand_range(0, 11))
		var third_color = int(rand_range(0, 11))
		var tile = tile_base.instance()
		#print(tile.get_node("TileLeft").material)
		set_material_color(color_pallete[first_color], tile.get_node("TileLeft"))
		set_material_color(color_pallete[second_color], tile.get_node("TileMiddle"))
		set_material_color(color_pallete[third_color], tile.get_node("TileRight"))
		tile.translation = position
		tile.tile_speed = tile_speed
		add_child(tile)
		count += 1
		var timer = Timer.new()
		timer.one_shot = true
		timer.wait_time = timer_wait_time
		add_child(timer)
		timer.connect("timeout", timer, "queue_free")
		timer.start()
		yield(timer,"timeout")
		
func set_material_color(color, mesh):
	var material = SpatialMaterial.new()
	material.roughness = 1
	material.metallic = 0
	material.albedo_color = color
	mesh.set_material_override(material)

func set_color_pallete(pallete):
	color_pallete = pallete

func set_number_of_tilesets(number):
	tiles_number = number

func set_timer_wait_time(time):
	timer_wait_time = time

func set_tile_speed(speed):
	tile_speed = speed

func _on_SwipeDetector_swipe(direction):
	print(direction)
	if direction.x == -1:
		# right
		if current_player_position_sum <= 0:
			current_player_position_sum += tiles_position_distance
			var current_position_vector = $Player.translation
			print(current_position_vector, current_player_position_sum)
			player_tween.interpolate_property($Player, "translation", current_position_vector, Vector3(current_player_position_sum, current_position_vector.y, current_position_vector.z), 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
			player_tween.start()
	elif direction.x == 1:
		# left
		if current_player_position_sum >= 0:
			current_player_position_sum -= tiles_position_distance
			var current_position_vector = $Player.translation
			print(current_position_vector, current_player_position_sum)
			player_tween.interpolate_property($Player, "translation", current_position_vector, Vector3(current_player_position_sum, current_position_vector.y, current_position_vector.z), 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
			player_tween.start()

func debug_print(data):
	print(data)

