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
	
func fix_pos():
	if position.x < 0:
		position.x = 0
		velocity.x *= -1
	if position.x > 480 * scene_scale():
		position.x = 480 * scene_scale() 
		velocity.x *= -1
	if position.y < 0:
		position.y = 0
		velocity.y *= -1
	if position.y > 720 * scene_scale():
		position.y = 720 * scene_scale() 
		velocity.y *= -1

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
	fix_pos()

func start(pos):
	position = pos
	set_mass(1)

func set_mass(m):
	mass = m
	var s = scene_scale()
	s = Vector2(s, s)
	$Node2D.scale = s
	$CollisionShape2D.scale = s
	
	
func _on_Player_area_entered(area):
	if area.mass < mass:
		$AudioStreamPlayer.pitch_scale = 2 * 1 / pow(mass, 0.1)
		$AudioStreamPlayer.play()
		set_mass(mass + area.mass)
		area.die()
	else:
		$DeathPlayer.play()
		emit_signal("hit")
