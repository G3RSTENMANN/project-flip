extends Node2D

const CARD_SCENE_PATH = "res://scenes/card.tscn"
const CARD_IMAGE_PATH = "res://assets/PC Computer - UNO - Cards Classic.png"
const CARD_DRAW_SPEED = 0.2

var player_deck = ["Uno", "Rot0", "Rot1", "Rot2"]
var card_database_reference


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_deck.shuffle()
	$RichTextLabel.text = str(player_deck.size())
	card_database_reference = preload("res://scripts/CardDatabase.gd")


func draw_card():
	# Delete Drawn Card from Deck
	var card_drawn_name = player_deck[0]
	player_deck.erase(card_drawn_name)
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		$RichTextLabel.visible = false

	# Update Deck-Counter
	$RichTextLabel.text = str(player_deck.size())

	# Instantiate Drawn Card in Hand
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	
	# Loading Card Texture from Single Image
	# var card_image_path = str("res://assets/" + card_drawn_name + ".png")
	#new_card.get_node("CardImage").texture = load(CARD_IMAGE_PATH)
	
	# Drawing specified Region of Image-Texture
	var image = Image.load_from_file("res://assets/PC Computer - UNO - Cards Classic.png")
	var img_texture = ImageTexture.create_from_image(
		image.get_region(
			Rect2(
				card_database_reference.CARDS[card_drawn_name][2][0],
				card_database_reference.CARDS[card_drawn_name][2][1],
				card_database_reference.CARDS[card_drawn_name][2][2],
				card_database_reference.CARDS[card_drawn_name][2][3]
			)
		)
	)
	new_card.get_node("CardImage").texture = img_texture
	
	# Setting Text on Cards
	new_card.get_node("Up").text = card_database_reference.CARDS[card_drawn_name][0]
	new_card.get_node("Down").text = card_database_reference.CARDS[card_drawn_name][1]
	
	
	# Integrating new card
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
