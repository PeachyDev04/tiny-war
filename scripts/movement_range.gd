extends Node

# Tiny War battlefield size
# The map has 12 columns and 8 rows
const COLUMNS = 12
const ROWS = 8

# Maximum movement distance for each unit
const MELEE_MOVE = 3
const RANGED_MOVE = 2
const TANK_MOVE = 1


# Get the movement range based on the unit type
func get_movement_range(unit_type: String) -> int:

	# Melee units can move 3 tiles
	if unit_type == "Melee":
		return MELEE_MOVE

	# Ranged units can move 2 tiles
	elif unit_type == "Ranged":
		return RANGED_MOVE

	# Tank units can move 1 tile
	elif unit_type == "Tank":
		return TANK_MOVE

	# Unknown units cannot move
	return 0


# Check whether a unit can move to a selected tile
func can_move(start: Vector2i, target: Vector2i, unit_type: String) -> bool:

	# Check if the starting tile is inside the battlefield
	if start.x < 0 or start.x >= COLUMNS:
		return false

	if start.y < 0 or start.y >= ROWS:
		return false

	# Check if the target tile is inside the battlefield
	if target.x < 0 or target.x >= COLUMNS:
		return false

	if target.y < 0 or target.y >= ROWS:
		return false

	# Calculate movement distance
	# Count horizontal and vertical tiles
	var distance = abs(target.x - start.x) + abs(target.y - start.y)

	# Check if movement is within the unit's limit
	return distance <= get_movement_range(unit_type)


# Automatically test movement when the scene starts
func _ready() -> void:

	print("===== MOVEMENT RANGE TEST =====")

	# Melee moving 3 tiles should be allowed
	print("Melee 3 tiles: ",
		can_move(Vector2i(2, 2), Vector2i(5, 2), "Melee"))

	# Melee moving 4 tiles should be blocked
	print("Melee 4 tiles: ",
		can_move(Vector2i(2, 2), Vector2i(6, 2), "Melee"))

	# Ranged moving 2 tiles should be allowed
	print("Ranged 2 tiles: ",
		can_move(Vector2i(2, 2), Vector2i(4, 2), "Ranged"))

	# Ranged moving 3 tiles should be blocked
	print("Ranged 3 tiles: ",
		can_move(Vector2i(2, 2), Vector2i(5, 2), "Ranged"))

	# Tank moving 1 tile should be allowed
	print("Tank 1 tile: ",
		can_move(Vector2i(2, 2), Vector2i(3, 2), "Tank"))

	# Tank moving 2 tiles should be blocked
	print("Tank 2 tiles: ",
		can_move(Vector2i(2, 2), Vector2i(4, 2), "Tank"))

	# Test moving outside the battlefield
	print("Outside battlefield: ",
		can_move(Vector2i(0, 0), Vector2i(-1, 0), "Melee"))

	print("===== TEST COMPLETE =====")
