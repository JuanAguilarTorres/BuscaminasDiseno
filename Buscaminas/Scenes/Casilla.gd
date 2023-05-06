extends Node2D

# Definir variables de control
var texture = StreamTexture.new()
var bombMed = "res://Assets/BombMed.png"
var bombDif = "res://Assets/BombDificil.png"
# Definir variables de operación
var cubierto = true
var esBomba = false
var dist = 55;

func ponerBomba():
	# Convertir en bomba
	esBomba = true
	# Definir dificultad
	var ran = randi() % 10 + 1
	if ran < 4:
		# Mediano
		var image = Image.new()
		image.load(bombMed)
		var image_texture = ImageTexture.new()
		image_texture.create_from_image(image)
		$Bomba.texture = image_texture
	if ran == 1:
		# Dificil
		var image = Image.new()
		image.load(bombDif)
		var image_texture = ImageTexture.new()
		image_texture.create_from_image(image)
		$Bomba.texture = image_texture
	
	$Bomba.show()

func descubrir():
	# Destapar casilla
	$Sobre.hide()
	$Id.hide()
	cubierto = false
	# Conocer vecinos alrededor
	if esBomba == false:
		var contarVecinos = 0
		for casilla in conseguirVecinos():
			if casilla.esBomba:
				contarVecinos += 1
		if contarVecinos > 0:
			# Mostrar cantidad de bombas alrededor
			$Num.text = str(contarVecinos)
			$Num.show()
		else:
			# Destapar todas las que no toquén bombas
			for casilla in conseguirVecinos():
				if casilla.cubierto:
					casilla.descubrir()

func conseguirVecinos():
	var alrededor = []
	# Detectar todas las casillas vecinas
	var pos = [
		(Vector2.UP + Vector2.LEFT) * dist,
		(Vector2.UP) * dist,
		(Vector2.UP + Vector2.RIGHT) * dist,
		Vector2.LEFT * dist,
		Vector2.RIGHT * dist,
		(Vector2.DOWN + Vector2.LEFT) * dist,
		(Vector2.DOWN) * dist,
		(Vector2.DOWN + Vector2.RIGHT) * dist,
	]
	for index in pos:
		for casilla in get_parent().plantadas:
			if casilla.position == position + index:
				alrededor.append(casilla)
	return alrededor

func _on_Control_gui_input(event):
	# Detecta el evento de destapar casilla
	if event is InputEventMouseButton:
		# Detección de Evento: Click.
		if event.button_index == BUTTON_LEFT and event.pressed:
			descubrir()
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()

func setdist(var nuevo):
	# Ajustar a tamaño
	dist = nuevo
	
func setId(let, num):
	$Id.text = str(let) + str(num)
