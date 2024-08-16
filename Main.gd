extends Node2D

export(PackedScene) var other_scene

func _ready():
	randomize()
	new_game()
	
func _process(delta):
	if not $Player.mass:
		return
	var target_scale = 1/sqrt($Player.mass)
	var current_scale = scale.x
	
	var s = lerp(current_scale, target_scale, delta) 
	scale = Vector2(s, s)
	$Path2D.scale = scale
	
func new_game():
	$Player.start($StartPosition.position)
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	var o = other_scene.instance()
	var location = get_node("Path2D/PathFollow2D")
	location.offset = randi()
	
	o.position = location.position
	o.compute_scale($Player.mass, 2 * randf())
	add_child(o)
