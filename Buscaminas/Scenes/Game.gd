extends Node2D

# Definir variables de control
var casilla = preload("res://Scenes/Casilla.tscn")
# Definir variables de operación
var fila
var col
var let
var num
var dist = 55
var numBombas
var plantadas

func _ready():
	# Calcular
	print("Hay ", (fila*col), " casillas. Se plantaron ", numBombas, " bombas.")
	randomize()
	# Crear casillas
	num = 0
	let = 65
	for x in fila:
		for y in col:
			var cas = casilla.instance()
			cas.position = Vector2(x, y) * dist
			cas.setId(char(let), num)
			add_child(cas)
			num = num+1
		num = 0
		let = let+1
	# Plantar bombas en seleccionadas
	plantadas = get_children()
	plantar()

func plantar():
	# Ubicar bomba
	var index = 0
	while index < numBombas:
		var casillaActual = plantadas[randi() % len(plantadas)]
		if casillaActual.esBomba == false:
			casillaActual.ponerBomba()
			index = index+1
			
func setSize(ancho, alto):
	# Definir tamaño
	fila = int(alto)
	col = int(ancho)
	# 20% De casillas como bombas.
	numBombas = (fila*col)/5

func setdist(var nuevo):
	# Ajustar a tamaño
	dist = nuevo
