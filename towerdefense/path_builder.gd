extends TileMapLayer


func _process(_delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	var local_map_pos := local_to_map(mouse_pos)
	var surrounding_cells_pos := get_surrounding_cells(local_map_pos)
	
	var surrounding_cells_occupation = {}

	var i := 0
	for surrounding_cell_pos in surrounding_cells_pos:
		i += 1
		if get_cell_source_id(surrounding_cell_pos) == -1: continue
		
		surrounding_cells_occupation[i] = surrounding_cell_pos
		print(surrounding_cells_occupation)
	
	#i = 0
	
	
	#print(surrounding_cells)
	#set_cell(local_map_pos, 0, Vector2i(0,0))
