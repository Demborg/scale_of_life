extends Node

export(PackedScene) var other_scene

func _ready():
	randomize()
	new_game()
	
func _process(delta):
	if not $Node2D/Player.mass:
		return
	var target_scale = 1/sqrt($Node2D/Player.mass)
	var current_scale = $Node2D.scale.x
	
	var s = lerp(current_scale, target_scale, delta) 
	$Node2D.scale = Vector2(s, s)
	$Control.set_weight($Node2D/Player.mass)

	
func new_game():
	$Node2D/Player.start($StartPosition.position)
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	var o = other_scene.instance()
	var location = get_node("Path2D/PathFollow2D")
	location.offset = randi()
	
	o.position = location.position / $Node2D.scale
	o.compute_scale($Node2D/Player.mass * 2 * randf())
	$Node2D.add_child(o)
