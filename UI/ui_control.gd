extends CanvasLayer

@onready var inventory_interface: Control = $InventoryInterface
@onready var term_interface: Control = $TermInterface

# inventory functions ---------------------------------------------------------

func set_player_inventory_data(inventory_data: InventoryData, player: CharacterBody3D) -> void:
	#print("set player inventory data")
	inventory_interface.set_player_inventory_data(inventory_data, player)
	

func toggle_inventory(external_inventory_owner = null):
	inventory_interface.set_visible(not inventory_interface.is_visible())
	
	
	# Can be depreciated because of mouse based mechanics
	#make it so that if inventory is visible we can use the mouse
	#if inventory_interface.is_visible():
	#	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#else:
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()


func toggle_term_interface() -> void:
	term_interface.set_visible(not term_interface.is_visible())
