extends Node

var health = 5

var inventory_data : InventoryData




func use_slot_data(slot_data: SlotData) -> void:
	slot_data.item_data.use(self)

func get_player_position() -> Vector2:
	# TODO: refactor this function so it takes advantage of te object layer
	return Vector2.ZERO

func heal(heal_value: int)-> void:
	health += heal_value
