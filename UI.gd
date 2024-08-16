extends Control

func set_weight(w):
	
	$Scale.text = "Weight:\n" + str(round(100 * w) / 100) + "kg"
