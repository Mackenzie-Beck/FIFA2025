extends CanvasLayer


@onready var term_interface: Control = $term_interface





func toggle_term_interface() -> void:
	term_interface.visible = !term_interface.visible
