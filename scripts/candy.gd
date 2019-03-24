extends Area2D

var color 
var special = false
var selected = false
var x
var y
var gx
var gy
var destX
var destY
var posX
var posY

signal selected(obj, option)
func _ready():
	randomize()
	#randomiza um numero inteiro entre 0 e 6 representando as cores
	color = int(rand_range(0,6))
	
	if rand_range(0,1) > 0.99:
		special = true
	if special:
		get_node("anim_candy").set_animation("shine_"+get_color(color))
	else:
		get_node("anim_candy").set_animation("normal_"+get_color(color))
		
	set_process(true)
		
	pass

func _process(delta):
	if destX == null or destY == null or (destX == x and destY == y): return 
	
	var delX = posX - get_pos().x
	var delY = posY - get_pos().y
	var speed = Vector2(0,0)
	#se estiver longe do destino desloca, senao ele esta bem perto e dar o set
	if abs(delX) > 20:
		speed.x = 100 * (delX - x)
		
	else:
		set_pos(Vector2(posX, get_pos().y))
		x = destX
	if abs(delY) > 20:
		speed.y = 100 * (delY - y)
		
	else:
		set_pos(Vector2(get_pos().x, posY))
		y = destY
	
	set_pos(get_pos() + speed * delta)
	
	pass
#função que seta a posiçao na matrix os doces
#a partir da posição do board soma x vzs o tamaho da figura o mesmo com a coord y
#especificando o centro da imagem que o tamnho divido por 2
func set_data(x,y):
	#referncia a propria variavel
	self.x = x
	self.y = y
	
	set_pos(Vector2(62 + x * 75 + 75/2, 290 + y * 75 + 75/2))
	pass

func get_color(n):
	if n == 0:
		return "blue"
	elif n == 1:
		return "green"
	elif n == 2:
		return "orange"
	elif n == 3:
		return "pink"
	elif n == 4:
		return "purple"
	elif n == 5:
		return "yellow"
	
	pass

func deselect():
	selected = false
	get_node("selected").hide()
	pass
func selected():
	selected = true
	get_node("selected").show()
	pass
#funcao para mover os doces
func move_to(gx,gy):
	destX = gx
	destY = gy
	
	#pega a posicao atual + (a posicao que se vai - a atual) vzs o tamanho da imagem
	posX = get_pos().x + (gx - x) * 75
	posY = get_pos().y + (gy - y) * 75
	
	pass

func _on_candy_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		if selected:
			deselect()
			#emite a funcao passando a s mesmo e o valor boleano
			emit_signal("selected", self, false)
		else:
			selected()
			emit_signal("selected", self, true)
	pass 
