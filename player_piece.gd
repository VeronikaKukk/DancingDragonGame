extends Node2D

@export var button_choices = [KEY_Q,KEY_W,KEY_E,KEY_R]
@export var reaction_time = 2.0
@export var texture_choices: Array[Texture]
var button_choice
var new_texture
var player_reacted = false
var is_timer_active = false
var random_index = 0
var speed = 100
var label_start_pos = Vector2(-400,0)
var next_change = 40
var suc_particle
var fai_particle
@onready var success_particle = preload("res://Scenes/success_particle.tscn")
@onready var fail_particle = preload("res://Scenes/fail_particle.tscn")

func _ready():
	get_node("/root/Main/timernode").change_values_signal.connect(_on_timernode_change_values_signal)
	Globals.game_over_signal.connect(on_game_over)
	reaction_time = Globals.reaction_time
	$Label.position = label_start_pos
	var size = Vector2($Sprite2D.texture.get_width(), $Sprite2D.texture.get_height()) * $Sprite2D.scale
	speed = ($Label.position.distance_to($Sprite2D.position- (size/5)))/ reaction_time
	suc_particle = success_particle.instantiate()
	suc_particle.emitting = false
	add_child(suc_particle)
	
	fai_particle = fail_particle.instantiate()
	fai_particle.emitting = false
	add_child(fai_particle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_timer_active and not player_reacted:
		# move button text towards sprite
		var dir = ($Sprite2D.position - $Label.position).normalized()
		$Label.position += dir * speed * delta
	elif not is_timer_active:
		if next_change <= 0:
			if random_index >= 3:
				random_index = 0
			else:
				random_index += 1
			change_appearance()
			next_change = 40
		else:
			next_change -= 1

func _input(event):
	if event is InputEventKey and is_timer_active and not player_reacted:
		if event.pressed and event.keycode in button_choices:
			if  event.keycode == button_choice:
				print("key pressed")
				player_reacted = true;
				Globals.successes += 1
				$SuccessSound.play()
				suc_particle.position = $Label.get_position()
				suc_particle.emitting = true
				$Label.position = label_start_pos
				$Label.text = "..."
			elif not player_reacted:
				$FailSound.play()
				fai_particle.position = $Label.get_position()
				fai_particle.emitting = true
				print("wrong key pressed")
				Globals.health -= 1
				

func choose_button():
	random_index = randi() % 4
	button_choice = button_choices[random_index]
	$Label.text = str(OS.get_keycode_string(button_choice))
	#print(OS.get_keycode_string(button_choice))

func change_appearance():
	# change the appearance of sprite to correct one
	$Sprite2D.texture = texture_choices[random_index]

func start_reaction():
	choose_button()
	change_appearance()
	player_reacted = false
	is_timer_active = true
	# starting reaction timer
	$Timer.one_shot = true
	$Timer.wait_time = reaction_time
	$Timer.start()

func _on_timer_timeout():
	is_timer_active = false
	if player_reacted:
		print("Success")
	else:
		print("Did not succeed")
		$FailSound.play()
		fai_particle.position = $Label.get_position()
		fai_particle.emitting = true
		Globals.health -= 1
	$Label.text = "..."
	$Label.position = label_start_pos


func _on_timernode_change_values_signal():
	start_reaction()

func on_game_over(_isWin):
	$Label.text = "..."
	$Label.position = label_start_pos
	$Timer.stop()
	is_timer_active = false
