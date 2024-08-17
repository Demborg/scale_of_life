extends Area2D

export var speed = 100 # How fast the player will move (pixels/sec).

var direction = Vector2.ZERO
var mass = 1

func momentum():
	return lerp(1 - 1/mass, 1, 0.3)

func randomVector():
	var v = Vector2(2 * randf() - 1, 2 * randf() - 1)
	if v.length_squared() > 1:
		return randomVector()
	return v

func _ready():
	direction = randomVector().normalized()

func _process(delta):
	position += speed * direction * delta * sqrt(mass)
	direction =lerp(randomVector().normalized(), direction, momentum()).normalized()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func compute_scale(m):
	mass = m
	var s = sqrt(m)
	s = Vector2(s, s)
	$AnimatedSprite.scale = s
	$CollisionShape2D.scale = s
	$VisibilityNotifier2D.scale = s
	
func die():
	queue_free()
