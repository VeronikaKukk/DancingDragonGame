extends Control


func _ready():
	$MenuBackgroundMusic.play()

func _on_start_button_pressed():
	play_button_click_sound()
	$MenuBackgroundMusic.stop()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_normal_start_button_pressed():
	Globals.reaction_time = 3.0
	Globals.wait_time = 6.0
	Globals.max_health = 12
	Globals.health = Globals.max_health
	Globals.max_success = 30
	Globals.mode = "Normal mode"
	_on_start_button_pressed()

func _on_hard_start_button_pressed():
	Globals.reaction_time = 1.5
	Globals.wait_time = 3.5
	Globals.max_health = 8
	Globals.health = Globals.max_health
	Globals.max_success = 20
	Globals.mode = "Hard mode"
	_on_start_button_pressed()

func _on_expert_start_button_pressed():
	Globals.reaction_time = 1.3
	Globals.wait_time = 2.4
	Globals.max_health = 6
	Globals.health = Globals.max_health
	Globals.max_success = 15
	Globals.mode = "Expert mode"
	_on_start_button_pressed()
	
func _on_instructions_button_pressed():
	play_button_click_sound()
	var options = preload("res://Scenes/options.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func _on_quit_button_pressed():
	play_button_click_sound()
	get_tree().quit()

func _on_options_button_pressed():
	play_button_click_sound()
	var options = preload("res://Scenes/game_options.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func play_button_click_sound():
	ButtonClick.play()
