extends Node

export(PackedScene) var other_scene

func _ready():
	randomize()
	new_game()
	
func _process(delta):
	if not $Node2D/Player.mass:
		return
	
	var player_mass =$Node2D/Player.mass
	$Control.set_weight(player_mass)
	for c in $Node2D/Others.get_children():
		c.set_danger(player_mass)
	
	var s = $Node2D/Player.camera_s()
	var pos = $Node2D/Player.camera_pos()
	$BG/TextureRect.material.set_shader_param("scale", s)
	$BG/TextureRect.material.set_shader_param("pos", pos)
	
	
func new_game():
	$Node2D/Player.show()
	$Node2D/Player.set_mass(1)
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	var o = other_scene.instance()
	var location = get_node("Path2D/PathFollow2D")
	location.offset = randi()
	
	o.position = (location.position - Vector2(240, 360)) * sqrt($Node2D/Player.mass) + $Node2D/Player.position
	o.compute_scale($Node2D/Player.mass * 2 * randf())
	$Node2D/Others.add_child(o)
	$SpawnTimer.wait_time = 1 / pow($Node2D/Player.mass, 0.2)


func _on_Player_hit():
	$Node2D/Player.hide()
	$Control.die()
	

func _on_Control_retry():
	new_game()
