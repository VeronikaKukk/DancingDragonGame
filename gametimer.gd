extends Node2D

signal change_values_signal()
@export var wait_time_between_change = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.game_over_signal.connect(on_game_over)
	wait_time_between_change = Globals.wait_time
	$Timer.wait_time = wait_time_between_change
	$Timer.start()

func _on_timer_timeout():
	# ytle koikidele et nad teeks asju
	emit_signal("change_values_signal")

func on_game_over(_isWin):
	$Timer.stop()
