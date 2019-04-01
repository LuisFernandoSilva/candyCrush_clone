extends CanvasLayer

var next_scene_path
#cena atual
var above_node 

func fade_to(path):
	next_scene_path = path
	get_node("anim").play("fade")
	pass

func change_scene():
	if next_scene_path != null:
		get_tree().change_scene(next_scene_path)
	pass
#coloca uma tela de sobreposição
func put_above(path):
	if above_node != null:
		return
	#pausa a root
	get_tree().set_pause(true)
	#pega a cena e a instancia
	above_node = load(path).instance()
	#sobrepoe na tela
	get_tree().get_root().add_child(above_node)
	
	pass
#retira a tela
func clear_above():
	if above_node == null:
		return 
	get_tree().set_pause(false)
	get_tree().get_root().remove_child(above_node)
	above_node = null
	
	pass
