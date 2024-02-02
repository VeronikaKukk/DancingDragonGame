extends Node2D

@onready var game_over_screen = preload("res://Scenes/game_over_screen.tscn")
func _ready():
	Globals.game_over_signal.connect(on_game_over)
	Globals.change_successes_signal.connect(change_success)
	Globals.emit_signal("change_successes_signal", Globals.successes)
	$BackgroundMusic.play()
	$Piece.change_appearance()
	$Piece2.change_appearance()
	$Piece3.change_appearance()

func on_game_over(_isWin):
	$BackgroundMusic.stop()
	get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")

func change_success(value):
	$CanvasLayer/success_label.text = "Success: "+str(value)+"/"+str(Globals.max_success)
