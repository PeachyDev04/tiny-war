@tool
extends Node2D

const COLUMNS = 12
const ROWS = 8
const TILE_SIZE = 64

func _draw() -> void:
	# vertical lines
	for x in range(COLUMNS + 1):
		var x_pos = x * TILE_SIZE
		draw_line(
			Vector2(x_pos, 0),
			Vector2(x_pos, ROWS * TILE_SIZE),
			Color(1, 1, 1, 0.6),
			1.5
		)

	# horizontal lines
	for y in range(ROWS + 1):
		var y_pos = y * TILE_SIZE
		draw_line(
			Vector2(0, y_pos),
			Vector2(COLUMNS * TILE_SIZE, y_pos),
			Color(1, 1, 1, 0.6),
			1.5
		)
