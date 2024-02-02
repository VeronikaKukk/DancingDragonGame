extends CanvasLayer


@onready var title = $PanelContainer/MarginContainer/Rows/Title

func  _ready():
	$MenuBackgroundMusic.play()
	set_title_and_sound(Globals.isWin)
	$PanelContainer/MarginContainer/Rows/healthlabel.text = "Lanterns remaining: " + str(Globals.health)+" (max "+str(Globals.max_health)+")"
	$PanelContainer/MarginContainer/Rows/modelabel.text = Globals.mode

func set_title_and_sound(isWin):
	if isWin:
		title.text = "You win!"
		$WinSound.play()
	else:
		title.text = "You lose!"
		$LoseSound.play()

func _on_restart_button_pressed():
	ButtonClick.play()
	$MenuBackgroundMusic.stop()
	Globals.reset_values()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_pressed():
	ButtonClick.play()
	get_tree().quit()


func _on_main_menu_button_pressed():
	ButtonClick.play()
	$MenuBackgroundMusic.stop()
	Globals.reset_values()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
