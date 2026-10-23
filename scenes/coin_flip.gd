extends Node2D

signal first_player_selected(player_number: int)

@onready var result_label = $ResultLabel

var first_player: int = 0

func _ready() -> void:
	flip_coin()

func flip_coin() -> void:
	first_player = randi_range(1, 2)

	if first_player == 1:
		result_label.text = "HEADS! Player 1 goes first!"
	else:
		result_label.text = "TAILS! Player 2 goes first!"

	print(result_label.text)
	first_player_selected.emit(first_player)
