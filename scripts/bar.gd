extends Sprite
#faz um atalho para o arquivo que pode ser modifica no inspector
export(String, FILE) var star_on

var points = 0
var p3 = 50
var p1 = (151.0/408)*p3
var p2 = (p1+p3)/2

func _ready():
	star_on = load(star_on)
	pass

func set_max(p_max):
	p3 = p_max
	p1 = (151.0/408)*p3
	p2 = (p1+p3)/2
	
	
	pass

func _on_candies_add_points(value):
	points += value
	#se pointa for maior que max
	if points > p3: points = p3
	#tamanho original da imagem vzs points divido pelo o maximo
	get_node("green").set_region_rect(Rect2(0,0,408*points/p3, 42))
	#maior ou igual
	if points >= p3:
		data.stars = 3 
		get_node("star_3").set_texture(star_on)
	elif points >= p2: 
		data.stars = 2
		get_node("star_2").set_texture(star_on)
	elif points >= p1: 
		data.stars = 1 
		get_node("star_1").set_texture(star_on)
	pass

func win():
	return  points >= p1
	pass
func win_max():
	return  points >= p3
	pass
