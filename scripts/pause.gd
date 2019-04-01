extends Node2D

func _ready():
	pass


func _on_return_button_pressed():
	get_node("anim").play("hide")
	#pega a animaçao e espera um sinal, so executa os comandos a baixo quando o sinal aparecer
	yield(get_node("anim"), "finished")
	transition.clear_above()
	pass 


func _on_home_button_pressed():
	get_node("anim").play("hide")
	#pega a animaçao e espera um sinal, so executa os comandos a baixo quando o sinal aparecer
	yield(get_node("anim"), "finished")
	transition.fade_to("res://scenes/main_screen.tscn")
	transition.clear_above()
	pass # replace with function body


func _on_replay_button_pressed():
	get_node("anim").play("hide")
	#pega a animaçao e espera um sinal, so executa os comandos a baixo quando o sinal aparecer
	yield(get_node("anim"), "finished")
	transition.fade_to("res://scenes/level.tscn")
	transition.clear_above()
	pass # replace with function body
