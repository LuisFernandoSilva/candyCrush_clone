extends Node

func _ready():
	pass


func _on_timer_timeout():
	transition.fade_to("res://scenes/main_screen.tscn")
	pass 
