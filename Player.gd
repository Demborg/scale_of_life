extends Area2D
signal hit
export var speed = 400 # How fast the player will move (pixels/sec).

var mass = 1

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta


func _on_Player_body_entered(body):
	if body.mass < mass:
		set_mass(mass + body.mass)
		body.die()
	else:
		print("death")

func start(pos):
	position = pos
	set_mass(1)

func set_mass(m):
	mass = m
	var s = sqrt(mass)
	s = Vector2(s, s)
	$AnimatedSprite.scale = s
	$CollisionShape2D.scale = s
	


func _on_Player_area_entered(area):
	if area.mass < mass:
		set_mass(mass + area.mass)
		area.die()
	else:
		print("death")
