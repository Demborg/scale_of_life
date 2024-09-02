extends CanvasLayer

signal retry

func set_weight(w):
	$Scale.text = "Weight:\n" + str(round(100 * w) / 100) + "kg"

func _on_Up_button_down():
	Input.action_press("ui_up")

func _on_Up_button_up():
	Input.action_release("ui_up")

func _on_Down_button_down():
	Input.action_press("ui_down")

func _on_Down_button_up():
	Input.action_release("ui_down")
	
func _on_Left_button_down():
	Input.action_press("ui_left")

func _on_Left_button_up():
	Input.action_release("ui_left")
	
func _on_Right_button_down():
	Input.action_press("ui_right")

func _on_Right_button_up():
	Input.action_release("ui_right")

func die():
	$Death.show()

func _on_Button_pressed():
	$Death.hide()
	emit_signal("retry")
