extends CanvasLayer


@onready var term_interface: Control = $term_interface
@onready var main_menu: Control = $Main_Menu



func _ready() -> void:
	main_menu.start_game.connect(_on_start_game)
	
	for child in get_children(true):
		if child is Button:
			AudioManager._connect_button(child)
	

func toggle_term_interface() -> void:
	term_interface.visible = !term_interface.visible

func _on_start_game() -> void:
	main_menu.visible = !main_menu.visible
	Utils.points = Utils.rng.randi_range(2,4)
	term_interface.set_points()
