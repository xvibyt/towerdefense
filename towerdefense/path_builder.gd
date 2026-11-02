extends TileMapLayer


var top_left_limit = Vector2i(1,2)
var bottom_right_limit = Vector2i(5,7)

var buildmode: bool = true

var paths: Dictionary
var checked_cells: Dictionary

func Extract_path(tree) -> Array:
	for key in tree:
		var value = tree[key]
		if typeof(value) == TYPE_VECTOR2I:
			return [key]
		elif typeof(value) == TYPE_DICTIONARY:
			var sub_path = Extract_path(value)
			if sub_path.size() > 0:
				var path = [key]
				path.append_array(sub_path)
				return path
	return []

func Next_path(surrounding_cells_pos, current_path):
	for surrounding_cell in surrounding_cells_pos:
		if surrounding_cell == Vector2i(4,7):
			current_path[surrounding_cell] = surrounding_cell
			return current_path[surrounding_cell]
		
		if checked_cells.has(surrounding_cell):
			continue
		checked_cells[surrounding_cell] = true
		
		if get_cell_source_id(surrounding_cell) == -1:
			current_path[surrounding_cell] = null
			continue
			
		current_path[surrounding_cell] = {}
		
		var next_surrounding_cells_pos = get_surrounding_cells(surrounding_cell)
		var result = Next_path(next_surrounding_cells_pos, current_path[surrounding_cell])
		if result != null:
			return current_path

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if buildmode: buildmode = false
		#else: buildmode = true
		paths[Vector2i(1,1)] = {}
		var surrounding_cells_pos = get_surrounding_cells(Vector2i(1,1))
		var path_to_end = Next_path(surrounding_cells_pos, paths[Vector2i(1,1)])
		await get_tree().create_timer(1).timeout
		if not path_to_end:
			print("NO PATH TO END")
			return
		var real_path_to_end = Extract_path(path_to_end)
		print(real_path_to_end)
		var Enemy = get_tree().current_scene.get_node("Enemy")
		for local_map_pos in real_path_to_end:
			var pos = map_to_local(local_map_pos)
			Enemy.position = pos + Vector2(-3, -3)
			await get_tree().create_timer(0.5).timeout
			
	
	#if not event.is_action_pressed("LeftMouseClick"): return
	if not buildmode or not Input.is_action_pressed("LeftMouseClick"): return
	
	var mouse_pos := get_global_mouse_position()
	var local_map_pos := local_to_map(mouse_pos)
	
	var check_return = Check(local_map_pos)
	var surrounding_cells_data
	if typeof(check_return) == TYPE_ARRAY:
		#print("SUCCESS")
		surrounding_cells_data = check_return
	else:
		#prints("ERROR", check_return)
		return
	
	var t = 0
	for array in surrounding_cells_data[0]:
		t += 1
		if not surrounding_cells_data[0][t]: continue
		
		var surrounding_cell_pos = surrounding_cells_data[1][t]
		Check(surrounding_cell_pos)

func Check(local_map_pos):
	var box := Rect2i(top_left_limit, bottom_right_limit - top_left_limit).abs()
	if not box.has_point(local_map_pos): return null
	
	var surrounding_cells_pos := get_surrounding_cells(local_map_pos)
	
	var surrounding_cells_occupation = {}
	var surrounding_cells_occupation_pos = {}
	
	var i := 0
	for surrounding_cell_pos in surrounding_cells_pos:
		i += 1
		if get_cell_source_id(surrounding_cell_pos) == -1:
			surrounding_cells_occupation[i] = false
			surrounding_cells_occupation_pos[i] = surrounding_cell_pos
			continue
		surrounding_cells_occupation[i] = true
		surrounding_cells_occupation_pos[i] = surrounding_cell_pos
		
	var atlas_source := tile_set.get_source(0) as TileSetAtlasSource
	for i2 in atlas_source.get_tiles_count():
		var atlas_coords := atlas_source.get_tile_id(i2)
		var data := atlas_source.get_tile_data(atlas_coords, 0)
		var direction_right: bool = data.get_custom_data("1")
		var direction_up: bool = data.get_custom_data("2")
		var direction_left: bool = data.get_custom_data("3")
		var direction_down: bool = data.get_custom_data("4")
		var directions = {1: direction_right, 2: direction_up, 3: direction_left, 4: direction_down}
		
		if not directions == surrounding_cells_occupation: continue
		
		set_cell(local_map_pos, 0, atlas_coords, 0)
		return [surrounding_cells_occupation, surrounding_cells_occupation_pos]
