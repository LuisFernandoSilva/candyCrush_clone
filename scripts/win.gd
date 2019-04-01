extends Node2D
export(String,FILE) var star_on

var stars

func _ready():
	stars = data.stars
	var level = data.current_level
	data.save_level(level, stars)
	#verifica se a proxima faze esta bloqueada e a desbloquea
	if data.save_data["level"+str(level +1)] == -1:
		data.save_level(level +1, 0)
	if stars >= 2:
		get_node("star_2").set_texture(load(star_on))
	if stars >= 3:
		get_node("star_3").set_texture(load(star_on))
	
	pass


func _on_home_button_pressed():
	get_node("anim").play("hide")
	#pega a animaçao e espera um sinal, so executa os comandos a baixo quando o sinal aparecer
	yield(get_node("anim"), "finished")
	transition.fade_to("res://scenes/main_screen.tscn")
	transition.clear_above()
	pass # replace with function body


func _on_return_button_pressed():
	get_node("anim").play("hide")
	#pega a animaçao e espera um sinal, so executa os comandos a baixo quando o sinal aparecer
	yield(get_node("anim"), "finished")
	transition.clear_above()
	pass # replace with function body


func _on_replay_button_pressed():
	get_node("anim").play("hide")
	#pega a animaçao e espera um sinal, so executa os comandos a baixo quando o sinal aparecer
	yield(get_node("anim"), "finished")
	transition.fade_to("res://scenes/level.tscn")
	transition.clear_above()
	pass # replace with function body


func _on_next_button_pressed():
	get_node("anim").play("hide")
	yield(get_node("anim"), "finished")
	
	data.current_level += 1
	if data.current_level > 6 :
		transition.fade_to("res://scenes/main_screen.tscn")
	else:
		transition.fade_to("res://scenes/level.tscn")
	transition.clear_above()
	pass # replace with function body
