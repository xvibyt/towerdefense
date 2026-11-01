extends TileMapLayer


func _process(_delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("LeftMouseClick"):
		var mouse_pos := get_global_mouse_position()
		var local_map_pos := local_to_map(mouse_pos)
		var surrounding_cells_pos := get_surrounding_cells(local_map_pos)
		
		var surrounding_cells_occupation = {}
		
		var i := 0
		for surrounding_cell_pos in surrounding_cells_pos:
			i += 1
			if get_cell_source_id(surrounding_cell_pos) == -1:
				surrounding_cells_occupation[i] = false
				continue
			#prints(local_map_pos, surrounding_cell_pos)
			surrounding_cells_occupation[i] = true
			
		prints(local_map_pos, "Surroundings", surrounding_cells_occupation)
			
		var atlas_source := tile_set.get_source(0) as TileSetAtlasSource
		for i2 in atlas_source.get_tiles_count():
			var atlas_coords := atlas_source.get_tile_id(i2)
			var data := atlas_source.get_tile_data(atlas_coords, 0)
			var direction_right: bool = data.get_custom_data("1")
			var direction_up: bool = data.get_custom_data("2")
			var direction_left: bool = data.get_custom_data("3")
			var direction_down: bool = data.get_custom_data("4")
			var directions = {1: direction_right, 2: direction_up, 3: direction_left, 4: direction_down}
			print(directions)
			
			if not directions == surrounding_cells_occupation: continue
			
			printt("set", atlas_coords)
			set_cell(local_map_pos, 0, atlas_coords, 0)
			
			
