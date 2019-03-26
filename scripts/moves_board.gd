extends Sprite
var moves = 15

func _ready():
	update_num()
	
	pass

func set_moves(m):
	moves = m
	update_num()
	pass
func update_num():
	
	get_node("number_1").set_texture(load("res://assets/texture/files/png/gui/Group_"+str(moves/10)+".png"))
	get_node("number_2").set_texture(load("res://assets/texture/files/png/gui/Group_"+str(moves%10)+".png"))
	pass


func _on_candies_played():
	moves -=1
	update_num()
	pass # replace with function body
