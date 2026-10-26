extends Node

const COLUMNS = 12
const ROWS = 8

const MELEE_MOVE = 3
const RANGED_MOVE = 2
const TANK_MOVE = 1


func get_movement_range(unit_type: String) -> int:
	if unit_type == "Melee":
		return MELEE_MOVE
	elif unit_type == "Ranged":
		return RANGED_MOVE
	elif unit_type == "Tank":
		return TANK_MOVE

	return 0


func can_move(start: Vector2i, target: Vector2i, unit_type: String) -> bool:
	# Check that the destination is inside the battlefield.
	if target.x < 0 or target.x >= COLUMNS:
		return false

	if target.y < 0 or target.y >= ROWS:
		return false

	# Calculate the number of tiles moved.
	var distance = abs(target.x - start.x) + abs(target.y - start.y)

	return distance <= get_movement_range(unit_type)
