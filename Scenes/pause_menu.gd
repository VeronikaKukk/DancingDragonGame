extends CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var exists = get_tree().get_root().get_node_or_null("Main/CanvasLayer/Options")
		if exists == null:
			get_tree().paused = true
			var options = preload("res://Scenes/game_options.tscn").instantiate()
			get_tree().get_root().get_node("Main/CanvasLayer").add_child(options)
		else:
			get_tree().paused = false
			exists.queue_free()
