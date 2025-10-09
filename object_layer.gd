extends TileMapLayer


@export var player_sprite_atlas_coords : Vector2 = Vector2(0,10)
@export var goal_sprite_atlas_coords : Vector2 = Vector2(0,6)

@export var player_coords : Vector2 = Vector2(0,0)
@export var goal_coords : Vector2 = Vector2(10,-10)


func _ready() -> void:
	set_cell(player_coords, 1, player_sprite_atlas_coords)
	set_cell(goal_coords,1,  goal_sprite_atlas_coords)
	print(get_cell_tile_data(Vector2(0,0)))
	print(QuestionBank.random_question())
