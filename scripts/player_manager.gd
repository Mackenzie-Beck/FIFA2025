extends Node

var health = 5

var inventory_data : InventoryData


func _physics_process(delta: float) -> void:
	# can put input scanning for player here
	if Input.is_action_just_pressed("inventory"):
		UI_control.toggle_inventory()
	


func use_slot_data(slot_data: SlotData) -> void:
	slot_data.item_data.use(self)

func get_player_position() -> Vector2:
	# TODO: refactor this function so it takes advantage of te object layer
	return Vector2.ZERO

func heal(heal_value: int)-> void:
	health += heal_value
