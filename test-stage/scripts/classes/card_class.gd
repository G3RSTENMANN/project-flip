class_name Card

var top_half : CardHalf
var bot_half : CardHalf

var card_name : String


func _init(top_list, bot_list, name) -> void:
	top_half = CardHalf.new(top_list)
	bot_half = CardHalf.new(bot_list)
	card_name = name
