extends Sprite
var x 
var y

#função que seta a posiçao na matrix os doces
#a partir da posição do board soma x vzs o tamaho da figura o mesmo com a coord y
#especificando o centro da imagem que o tamnho divido por 2
func set_data(x,y):
	#referncia a propria variavel
	self.x = x
	self.y = y
	
	set_pos(Vector2(62 + x * 75 + 75/2, 290 + y * 75 + 75/2))
	pass