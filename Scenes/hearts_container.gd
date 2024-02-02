extends HBoxContainer

@onready var heart_GUI_class = preload("res://Scenes/heart_gui.tscn")

func _ready():
	Globals.change_hearts_signal.connect(update_hearts)
	Globals.emit_signal("change_hearts_signal", Globals.health)

func update_hearts(value):
	var ch = get_children()
	for i in range(len(ch)):
		remove_child(ch[i])
	
	for i in range(value):
		var heart = heart_GUI_class.instantiate()
		add_child(heart)
