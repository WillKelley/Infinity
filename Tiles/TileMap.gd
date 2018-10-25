extends TileMap

var cell_x
var cell_y
var cell_type

var drawing = null

func _ready():

	set_cell(0 , 0 , 0)
	set_cell(1, 0 , 1)
func _process(delta):

	if drawing:
		
		set_cell(cell_x, cell_y, cell_type)
		