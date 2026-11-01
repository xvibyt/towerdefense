extends TileMapLayer


func _process(_delta: float) -> void:
	pass

func _input(event):
	if not event.is_action_pressed("LeftMouseClick"): return
	
	var mouse_pos := get_global_mouse_position()
	var local_map_pos := local_to_map(mouse_pos)
	
	var surrounding_cells_data: Array = Check(local_map_pos)
	
	var n = 0
	for array in surrounding_cells_data[0]:
		n += 1
		if not surrounding_cells_data[0][n]: continue
		
		var surrounding_cell_pos = surrounding_cells_data[1][n]
		Check(surrounding_cell_pos)

func Check(local_map_pos):
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
