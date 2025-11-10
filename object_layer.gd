extends TileMapLayer


@export var player_sprite_atlas_coords : Vector2 = Vector2(0,10)
@export var goal_sprite_atlas_coords : Vector2 = Vector2(0,6)

@export var player_coords : Vector2 = Vector2(0,0)
@export var goal_coords : Vector2 = Vector2(10,-10)



	
func initialize_game_world(equation :String):
	# clear the y= from the string so it fits the expression
	var cleaned_equation = equation.substr(2)
	
	
	# generate expression from the question bank and calculate values for coordiantes
	var expression = Expression.new()
	expression.parse(cleaned_equation, ["x"])
	
	var player_x_coord = Utils.rng.randi_range(-1,1)
	var goal_offset = Utils.rng.randi_range(-1,1)
	
	#print("expression : ", cleaned_equation)
	#print("player x coord: ", player_x_coord, " goal offset: ", goal_offset)
	#
	#print("player coords: ", Vector2(player_x_coord, -expression.execute([player_x_coord])))
	#
	#print("goal coords: ", Vector2((player_x_coord+goal_offset), -expression.execute([player_x_coord+goal_offset]) ) )
	
	
	set_player_coords(Vector2(player_x_coord, -expression.execute([player_x_coord])))
	set_goal_coords(Vector2((player_x_coord+goal_offset), -expression.execute([player_x_coord+goal_offset]) ) )
	
func set_player_coords(coords : Vector2):
	player_coords = coords
	set_cell(player_coords, 1, player_sprite_atlas_coords)
	
func set_goal_coords(coords : Vector2):
	goal_coords = coords
	set_cell(goal_coords,1,  goal_sprite_atlas_coords)

	
