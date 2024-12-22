class_name CardHalf

var path_name : String
var cost : int
var text : String

func _init(list) -> void:
	path_name = list[0]
	cost = list[1]
	text = list[2]
