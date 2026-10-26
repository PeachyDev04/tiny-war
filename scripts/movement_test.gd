extends Node2D

# Battlefield settings
const COLUMNS = 12
const ROWS = 8
const TILE_SIZE = 64

# Use our existing movement range checker
const MovementRange = preload("res://scripts/movement_range.gd")

var movement_checker = MovementRange.new()

# Three units with different positions and types
var units = [
	{"type": "Melee", "position": Vector2i(2, 2), "color": Color.BLUE},
	{"type": "Ranged", "position": Vector2i(5, 2), "color": Color.GREEN},
	{"type": "Tank", "position": Vector2i(8, 2), "color": Color.RED}
]

# Stores which unit the player selected
var selected_unit = -1


# Draw the battlefield and units
func _draw() -> void:

	# Draw vertical grid lines
	for x in range(COLUMNS + 1):
		draw_line(
			Vector2(x * TILE_SIZE, 0),
			Vector2(x * TILE_SIZE, ROWS * TILE_SIZE),
			Color.WHITE,
			1.0
		)

	# Draw horizontal grid lines
	for y in range(ROWS + 1):
		draw_line(
			Vector2(0, y * TILE_SIZE),
			Vector2(COLUMNS * TILE_SIZE, y * TILE_SIZE),
			Color.WHITE,
			1.0
		)

	# Draw all three units
	for i in range(units.size()):
		var unit = units[i]
		var pos = unit["position"]

		var center = Vector2(
			pos.x * TILE_SIZE + TILE_SIZE / 2.0,
			pos.y * TILE_SIZE + TILE_SIZE / 2.0
		)

		draw_circle(center, 20, unit["color"])

		# Draw a white ring around the selected unit
		if i == selected_unit:
			draw_arc(center, 25, 0, TAU, 32, Color.WHITE, 3.0)


# Handle mouse clicks
func _input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			# Convert mouse position into grid coordinates
			var mouse_pos = get_local_mouse_position()

			var target = Vector2i(
				floori(mouse_pos.x / TILE_SIZE),
				floori(mouse_pos.y / TILE_SIZE)
			)

			# Check if the player clicked on a unit
			for i in range(units.size()):
				if units[i]["position"] == target:
					selected_unit = i

					print("Selected: ", units[i]["type"])
					queue_redraw()
					return

			# If no unit is selected, do nothing
			if selected_unit == -1:
				return

			var unit = units[selected_unit]

			# Check movement using our movement range script
			if movement_checker.can_move(
				unit["position"],
				target,
				unit["type"]
			):

				# Move the selected unit
				units[selected_unit]["position"] = target

				print(unit["type"], " movement allowed!")

			else:
				print(unit["type"], " movement blocked!")

			queue_redraw()
