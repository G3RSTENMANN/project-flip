class_name Card

var top_half : CardHalf
var bot_half : CardHalf


func _init(top_list, bot_list) -> void:
	top_half = CardHalf.new(top_list)
	bot_half = CardHalf.new(bot_list)
