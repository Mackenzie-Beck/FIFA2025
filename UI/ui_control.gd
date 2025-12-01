extends CanvasLayer


@onready var term_interface: Control = $term_interface
@onready var main_menu: Control = $Main_Menu



func _ready() -> void:
	main_menu.start_game.connect(_on_start_game)
	

func toggle_term_interface() -> void:
	term_interface.visible = !term_interface.visible

func _on_start_game() -> void:
	main_menu.visible = !main_menu.visible
