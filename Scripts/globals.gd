extends Node

signal game_over_signal()
signal change_hearts_signal()
signal change_successes_signal()
var isWin = false
var max_success = 20
var reaction_time = 2.0
var wait_time = 5.0
var max_health = 10
var mode = "Normal mode"
@export var health = 10:
	set(new_health):
		health = new_health
		if health <= 0:
			isWin = false
			emit_signal("game_over_signal", isWin)
		emit_signal("change_hearts_signal", health)
			
@export var successes = 0:
	set(new_successes):
		successes = new_successes
		if successes >= max_success:
			isWin = true
			emit_signal("game_over_signal", isWin)
		emit_signal("change_successes_signal", successes)

func _ready():
	health = max_health

func reset_values():
	health = max_health
	successes = 0
	isWin = false
