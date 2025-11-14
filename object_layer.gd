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
	
	
	if !Utils.update_line.is_connected(draw_line_on_grid):
		Utils.update_line.connect(draw_line_on_grid)
	
func set_player_coords(coords : Vector2):
	player_coords = coords
	set_cell(player_coords, 1, player_sprite_atlas_coords)
	
func set_goal_coords(coords : Vector2):
	goal_coords = coords
	set_cell(goal_coords,1,  goal_sprite_atlas_coords)

	#print(get_cell_tile_data(Vector2(0,0)))
	#print(QuestionBank.random_question())


func draw_line_on_grid(equation : String) -> void:
	print("Current equation: ", equation)
	# generate expression from the question bank and calculate values for coordiantes
	var expression = Expression.new()
	
	# check if the left had side of equaiton is correct
	var equation_start = equation.substr(0,2)
	if equation_start != "y=":
		print("equation dont start right")
		return
		
	var cleaned_equation = equation.substr(2)
	print(cleaned_equation)
	var error = expression.parse(cleaned_equation)

	if error != 0:
		print("Invalid equation format!")
		print("Error: ", expression.get_error_text())
		return
	
	# If we get here, the equation is valid
	print("Equation is valid!")
	
	# this function should draw a line according to the equation made by the player
	#var line = Line2D.new()
	#line.add_point(map_to_local(player_coords))
	#line.add_point(map_to_local(goal_coords))
	#line.width = 2
	#line.default_color = Color.RED
	#add_child(line)
