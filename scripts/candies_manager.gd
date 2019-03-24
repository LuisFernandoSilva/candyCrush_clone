extends Node
#nessa versao da godot nao existe matrix fazer a manual
var matrix = []
var candies_pre = preload("res://scenes/candy.tscn")
#objetos para a troca conforme a identificaçao dos sinais
var obj1
var obj2
func _ready():
	clear_matrix()
	rand_matrix()
	
	pass
	
func clear_matrix():
	#para cada uma das colunas ,adiciona uma array vazia, e pega a coluna x e inicializa vazia 
	for x in range(9):
		matrix.append([])
		matrix[x] = []
		#para cada uma das linhas, adiciona no array x uma array vazia, e inicializa a matrix x e y como nula
		for y in range(12):
			matrix[x].append([])
			matrix[x][y] = null
		
	pass

func rand_matrix():
	for x in range(9):
		for y in range(12):
			if matrix[x][y] == null:
				matrix[x][y] = generate_candies(x,y)
	pass

func generate_candies(x,y):
	var new_candy = candies_pre.instance()
	new_candy.set_data(x,y)
	#conecta com o sinal em si mesmo e chama a funcao
	new_candy.connect("selected", self, "obj_selected")
	add_child(new_candy)
	return new_candy

func obj_selected(obj,option):
	if option:
		if obj1 == null:
			obj1 = obj
		else:
			obj2 = obj
			if test_close():
				obj1.move_to(obj2.x,obj2.y)
				obj2.move_to(obj1.x, obj1.y)
				#troca na matrix
				matrix[obj1.x][obj1.y] = obj2
				matrix[obj2.x][obj2.y] = obj1
				get_node("delay").start()
			else:
				obj1.deselect()
				obj2.deselect()
				obj1 = null
				obj2 = null
	pass

func test_close():
	#abs pega so numeros posivos
	#um obj esta do lado do outro se o x for igual e a diferença dos y for 1 e vice e versa
	if obj1.x == obj2.x and abs(obj1.y - obj2.y) == 1 or obj1.y == obj2.y and abs(obj1.x - obj2.x) == 1:
		return true
	else:
		return false
# percorre a matriz na horizonta e vertical add em um lista os itens iguais para a remoçao
#da matriz 
func find_pattern():
	var to_remove = []
	var valid = false
	#para cda linha, na segunda e penultima coluna
	for y in range(12):
		for x in range(1,8):
			#pega uma variavel e coloca a cor do anterior
			#que so verdade se c0 for dirente de nulo caso contrario e nulo(evita erros em espaços em brancos)
			var c0 = matrix[x-1][y].color if matrix[x-1][y] != null else null
			#cor do item atual
			var c1 = matrix[x][y].color if matrix[x][y] != null else null
			#cor do proximo
			var c2 = matrix[x+1][y].color if matrix[x+1][y] != null else null
			#add na lista de remoçao
			if c0 == c1 and c1 == c2 and c0 != null:
				add_to_remove(to_remove, matrix[x-1][y])
				add_to_remove(to_remove, matrix[x][y])
				add_to_remove(to_remove, matrix[x+1][y])
				valid = true
	#para cada coluna
	for x in range(9):
		for y in range(1,11):
			#pega uma variavel e coloca a cor do anterior, 
			#que so verdade se c0 for dirente de nulo caso contrario e nulo(evita erros em espaços em brancos)
			var c0 = matrix[x][y-1].color if matrix[x][y-1] != null else null
			#cor do item atual
			var c1 = matrix[x][y].color if matrix[x][y] != null else null
			#cor do proximo
			var c2 = matrix[x][y+1].color if matrix[x][y+1] != null else null
			#add na lista de remoçao
			if c0 == c1 and c1 == c2 and c0 != null:
				add_to_remove(to_remove, matrix[x][y-1])
				add_to_remove(to_remove, matrix[x][y])
				add_to_remove(to_remove, matrix[x][y+1])
				valid = true
	#para cada item na lista vamos remove lo ao final
	for i in to_remove:
		remove_child(i)
		matrix[i.x][i.y] = null
	
	move_down()
	
	return valid
	pass
	
func move_down():
	#para cada linha percorre uma a uma decrementando em um, nas colunas 
	for y in range(11, -1, -1):
		var x  = 0
		#enquanto x for menor que 8
		while(x <=8):
			if y == 0:
				if matrix[x][y] == null:
					matrix[x][y] = generate_candies(x,y)
			#se a matrix nao estiver nula
			if matrix[x][y] != null:
				var moved = false
				var toY
			#olha para baixo pra verificar se esta vazia, para o doce poder descer
				for i in range( y + 1,12):
					if matrix[x][i] == null:
						toY = i
						moved = true
					else:
						break
			
				if moved:
					matrix[x][y].move_to(x,toY)
					matrix[x][toY] = matrix[x][y]
					matrix[x][y] = null
			#caso ainda tenha espaço em banco nao incrementamos o x 
			if y == 0 and matrix[x][y] == null:
				pass
			else:
				x +=1
		
	pass
func add_to_remove(list,obj):
	if not list.has(obj):
		list.append(obj)
	pass

func _on_delay_timeout():
	if (find_pattern()):
		pass
	else:
		obj1.move_to(obj2.x,obj2.y)
		obj2.move_to(obj1.x, obj1.y)
		matrix[obj1.x][obj1.y] = obj2
		matrix[obj2.x][obj2.y] = obj1
		
	obj1.deselect()
	obj2.deselect()
	obj1 = null
	obj2 = null
	pass 
