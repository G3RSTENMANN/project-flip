extends Node2D

const CARD_SCENE_PATH = "res://scenes/card.tscn"
const REL_IMG_PATH = "res://assets/cards/"
const CARD_DRAW_SPEED = 0.2

var db_ref
var player_deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	db_ref = preload("res://scripts/CardDatabase.gd")
	player_deck = [
		Card.new(db_ref.CARDS["Spark"], db_ref.CARDS["Spark"], db_ref.CARDS["Spark"][3]),
		Card.new(db_ref.CARDS["UTurn"], db_ref.CARDS["UTurn"], db_ref.CARDS["UTurn"][3]),
		Card.new(db_ref.CARDS["BoneShield"], db_ref.CARDS["BoneShield"], db_ref.CARDS["BoneShield"][3]),
		Card.new(db_ref.CARDS["Spark"], db_ref.CARDS["BG"], db_ref.CARDS["Spark"][3]),
		Card.new(db_ref.CARDS["UTurn"], db_ref.CARDS["Spark"], db_ref.CARDS["UTurn"][3]),
		Card.new(db_ref.CARDS["BG"], db_ref.CARDS["BoneShield"], db_ref.CARDS["BG"][3]),
		# Card.new(db_ref.CARDS[""], db_ref.CARDS[""]),
	]
	player_deck.shuffle()
	$RichTextLabel.text = str(player_deck.size())


func draw_card():
	# Delete Drawn Card from Deck
	var new_card_data = player_deck.pop_front()
	var card_top_name = new_card_data.top_half.path_name
	var card_bot_name = new_card_data.bot_half.path_name
	
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
	var card_image_path_top = str(REL_IMG_PATH + card_top_name + ".png")
	var card_image_path_bot = str(REL_IMG_PATH + card_bot_name + ".png")
	new_card.get_node("TopImage").texture = load(card_image_path_top)
	new_card.get_node("BotImage").texture = load(card_image_path_bot)
	
	# Drawing specified Region of Image-Texture
	#var image = Image.load_from_file("res://assets/PC Computer - UNO - Cards Classic.png")
	#var img_texture = ImageTexture.create_from_image(
		#image.get_region(
			#Rect2(
				#card_database_reference.CARDS[card_drawn_name][2][0],
				#card_database_reference.CARDS[card_drawn_name][2][1],
				#card_database_reference.CARDS[card_drawn_name][2][2],
				#card_database_reference.CARDS[card_drawn_name][2][3]
			#)
		#)
	#)
	#new_card.get_node("CardImage").texture = img_texture
	
	# Setting Text on Cards
	new_card.get_node("Up").text = str(new_card_data.top_half.cost)
	new_card.get_node("Down").text = str(new_card_data.bot_half.cost)
	new_card.get_node("TxtUp").text = new_card_data.top_half.text
	new_card.get_node("TxtDown").text = new_card_data.bot_half.text
	new_card.get_node("TxtName").text = new_card_data.card_name


	# Integrating new card
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
