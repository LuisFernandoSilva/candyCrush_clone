extends Area2D
#variavel pode ser mudada no inspetor
export(int) var level = 0

func _ready():
	
	get_node("number").set_texture(load("res://assets/texture/files/png/gui/Group_"+str(level)+".png"))
	
	pass


func _on_level_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		transition.fade_to("res://scenes/level.tscn")
	pass # replace with function body
	