extends Area2D
signal hit
export var normalized_speed = 400 # How fast the player will move (pixels/sec).
var velocity = Vector2.ZERO

var mass = 1

func momentum():
	return 1 - 1/mass
	
func max_speed():
	return normalized_speed * sqrt(mass)

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

func start(pos):
	position = pos
	set_mass(1)

func set_mass(m):
	mass = m
	var s = sqrt(mass)
	s = Vector2(s, s)
	$Node2D.scale = s
	$CollisionShape2D.scale = s
	
	
func _on_Player_area_entered(area):
	if area.mass < mass:
		set_mass(mass + area.mass)
		area.die()
	else:
		emit_signal("hit")
