extends Node

var save_file = File.new()
var save_path = "user://save_game.data"
var save_data = {"level1":0,
				"level2":-1,
				"level3":-1,
				"level4":-1,
				"level5":-1,
				"level6":-1}
var current_level = 1
var stars = 0

func _ready():
	if not save_file.file_exists(save_path):
		save()
	read()
	pass

func save():
	save_file.open(save_path, File.WRITE)
	save_file.store_var(save_data)
	save_file.close()
	pass

func read():
	save_file.open(save_path, File.READ)
	save_data = save_file.get_var()
	save_file.close()
	pass

func save_level(level,stars):
	if level > 6: return
	save_data["level"+str(level)] = stars
	save()
	
	pass
