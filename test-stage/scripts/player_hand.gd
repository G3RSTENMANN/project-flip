extends Node2D

const CARD_WIDTH = 150
const HAND_Y_POS = 890
const DEFAULT_CARD_MOVE_SPEED = 0.1

var player_hand = []
var center_screen_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x = get_viewport().size.x / 2

func add_card_to_hand(card, speed):
	if card not in player_hand:
		player_hand.insert(0, card)
		update_hand_positions(speed)
	else:
		animate_card_to_position(card, card.hand_pos, DEFAULT_CARD_MOVE_SPEED)

func update_hand_positions(speed):
	for i in range(player_hand.size()):
		# Get new card position based on index
		var new_pos = Vector2(calculate_card_pos(i), HAND_Y_POS)
		var card = player_hand[i]
		card.hand_pos = new_pos
		animate_card_to_position(card, new_pos, speed)
		
func calculate_card_pos(idx):
	var total_hand_width = (player_hand.size() - 1) * CARD_WIDTH
	var x_pos = center_screen_x + idx * CARD_WIDTH - total_hand_width / 2
	return x_pos

func animate_card_to_position(card, pos, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", pos, speed)

func remove_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		update_hand_positions(DEFAULT_CARD_MOVE_SPEED)
