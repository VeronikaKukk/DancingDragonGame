extends Control

func _on_back_button_pressed():
	ButtonClick.play()
	get_tree().paused = false
	queue_free()
