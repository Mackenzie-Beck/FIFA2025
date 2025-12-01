extends TileMapLayer


@export var player_sprite_atlas_coords : Vector2 = Vector2(0,10)
@export var goal_sprite_atlas_coords : Vector2 = Vector2(0,6)

@export var player_coords : Vector2 = Vector2(0,0)
@export var goal_coords : Vector2 = Vector2(10,-10)



	
func initialize_game_world(equation :String):
	print("equation in initialize game world: ", equation)
	
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
	print("player coord at: ",player_x_coord, " ", expression.execute([player_x_coord])  )
	
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

func clear_lines_on_grid():
		# clean any lines
	for child in get_children():
		if child is Line2D:
			print(child)
			child.queue_free()

func draw_line_on_grid(equation : String) -> void:
	
	# clean any lines
	clear_lines_on_grid()
			
			
			
	#print("Current equation: ", equation)
	# generate expression from the question bank and calculate values for coordiantes
	var expression = Expression.new()
	
	# check if the left had side of equaiton is correct
	var equation_start = equation.substr(0,2)
	if equation_start != "y=":
		#print("left hand side of equation is wrong")
		return
		
	var cleaned_equation = equation.substr(2)
	
		# Remove all _ characters
	var result = ""
	for i in range(cleaned_equation.length()):
		var char = cleaned_equation[i]
		if char != "_":
			result += char
	cleaned_equation = result
	#print("Cleaned equation: '", cleaned_equation, "'")  # Debug print
	
	var error = expression.parse(cleaned_equation, ['x'])

	if error != 0:
		print("Invalid equation format!")
		print("Error: ", expression.get_error_text())
		return
	
	# If we get here, the equation is valid
	#print("Equation is valid!")
	
	# this function should draw a line according to the equation made by the player
	# Generate points along the line
	var line = Line2D.new()
	
	# Define the range of x values you want to plot
	var x_start = -30  # Adjust based on your grid
	var x_end = 30
	var step = 1  # Smaller step = smoother line


	# Calculate y for each x and add points
	for x in range(x_start, x_end + step, step):
		var y = -expression.execute([x])
		if expression.has_execute_failed():
			print("Execution failed at x=", x, ": ", expression.get_error_text())
			continue
		
		# Convert to screen/grid coordinates
		var point = Vector2(x, y)
		line.add_point(map_to_local(point))  
	
	line.width = 2
	if get_parent().is_equation_correct():
		line.default_color = Color.WEB_GREEN
	else:
		line.default_color = Color.DARK_RED
	add_child(line)

func reset_grid() -> void:
	var used_rect = get_used_rect()
	
	var tile_source_id = 0
	var tile_atlas_coords = Vector2i(0, 0)
	var tile_layer = 0
	
	# Loop through every cell in the used rectangle
	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			print(x,y)
			set_cell(Vector2i(x, y), tile_source_id, tile_atlas_coords)

		notify_runtime_tile_data_update()  # Force redraw

func clear_board_state():
	clear_lines_on_grid()
	#player
	set_cell(player_coords, -1)
	#goal
	set_cell(goal_coords, -1)
	reset_grid()


func _on_update_equation(equation :String):
	clear_board_state()
	initialize_game_world(equation)
