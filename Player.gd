extends Area2D
signal hit
export var normalized_speed = 400 # How fast the player will move (pixels/sec).
var velocity = Vector2.ZERO

var mass = 1

func momentum():
	return 1 - 1/pow(mass, 0.5)
	
func scene_scale():
	return sqrt(mass)
	
func max_speed():
	return normalized_speed * scene_scale()

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	velocity = lerp(direction * max_speed(), velocity, momentum())
	position += velocity * delta
	
	var target_zoom = scene_scale()
	var current_zoom = $Camera2D.zoom.x
	var zoom = lerp(current_zoom, target_zoom, delta)
	$Camera2D.zoom = Vector2(zoom, zoom)

func start(pos):
	position = pos
	set_mass(1)

func set_mass(m):
	mass = m
	var s = scene_scale()
	
	var s_vec = Vector2(s, s)
	$Node2D.scale = s_vec
	$CollisionShape2D.scale = s_vec

func camera_s():
	return $Camera2D.zoom.x
	
func camera_pos():
	return $Camera2D.global_position / Vector2(480, 720)
	
func _on_Player_area_entered(area):
	if area.mass < mass:
		$AudioStreamPlayer.pitch_scale = 2 * 1 / pow(mass, 0.1)
		$AudioStreamPlayer.play()
		set_mass(mass + area.mass)
		area.die()
	else:
		$DeathPlayer.play()
		emit_signal("hit")
