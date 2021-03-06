extends Node2D

export (int) var unit_room_size : int = 20

export (Array, PackedScene) var rooms : Array

onready var Rooms : Node2D = $Rooms

var position_array = [
	{"size":  7, "area": 3, "y_offset": 5},
	{"size": 12, "area": 2, "y_offset": 4},
	{"size":  9, "area": 3, "y_offset": 2},
	{"size":  8, "area": 4, "y_offset": 0},
	{"size":  9, "area": 3, "y_offset": 2},
	{"size":  8, "area": 4, "y_offset": 0},
	{"size":  9, "area": 3, "y_offset": 2},
	{"size": 12, "area": 2, "y_offset": 4}
]

func level_layout_cycle(
	position_array : Array,
	unit_room_size : int,
	x_offset : int,
	start : int = 0,
	end : int = 8
) -> int:
	for column_idx in range(position_array.size()):
		if start > column_idx: continue
		if end <= column_idx: break
		
		var column : Dictionary = position_array[column_idx]
		var room_scale : int = column.area * unit_room_size
		
		for room_idx in range(column.size):
			var grid_position = Vector2(column_idx, room_idx)
			var rand_room_idx = randi() % self.rooms.size()
			var new_room = self.rooms[rand_room_idx].instance()
			
			new_room.id = [grid_position.x, grid_position.y]
			new_room.size = room_scale
			new_room.position = Vector2(
				x_offset,
				unit_room_size * column.y_offset + room_scale * room_idx
			)
			
			self.Rooms.add_child(new_room)
		
		x_offset += unit_room_size * column.area
	
	return x_offset

func level_layout(
	position_array : Array,
	unit_room_size : int,
	start_x : int,
	cycle_start : int,
	n_loops : int,
	cycle_end : int
) -> void:
	var x_acc = self.level_layout_cycle(position_array, unit_room_size, start_x, cycle_start)
	for n in range(n_loops):
		x_acc = self.level_layout_cycle(position_array, unit_room_size, x_acc)
	self.level_layout_cycle(position_array, unit_room_size, x_acc, 0, cycle_end)

func _ready():
	self.level_layout(self.position_array, self.unit_room_size, 0, 2, 2, 4)
