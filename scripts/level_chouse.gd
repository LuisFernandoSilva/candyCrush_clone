extends Area2D
#variavel pode ser mudada no inspetor
export(int) var level = 0
export(String, FILE) var marker_onlock
export(String, FILE) var star_1
export(String, FILE) var star_2
export(String, FILE) var star_3

var stars
func _ready():
	stars = data.save_data["level"+str(level)]
	if stars != -1: get_node("lock").set_texture(load(marker_onlock))
		if stars != 0: get_node("stars").show()
		if stars == 1: get_node("stars").set_texture(load(star_1))
		elif stars == 2: get_node("stars").set_texture(load(star_2))
		elif stars == 3: get_node("stars").set_texture(load(star_3))
		
	get_node("number").set_texture(load("res://assets/texture/files/png/gui/Group_"+str(level)+".png"))
	
	pass


func _on_level_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and stars != -1:
		data.current_level = level
		transition.fade_to("res://scenes/level.tscn")
	pass # replace with function body
	