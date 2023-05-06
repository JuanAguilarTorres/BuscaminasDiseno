extends Node2D

# Definir variables de control
var game_scene = load("res://Scenes/Game.tscn")
var box_scene = load("res://Scenes/BoxCont.tscn")
var custom_font = DynamicFont.new()
# Definir variables de interfaz
var box_instanceAncho
var box_instanceAlto
var width_label
var height_label
var info_label
var button
# Definir variables de operación
var center
var ancho
var alto


func _ready():
	# Detecta centro de resolución actual.
	center = get_viewport_rect().size / 2
	# Inicializa la fuente.
	custom_font.font_data = load("res://Fonts/PixelA.ttf")
	
	# Crea el color de fondo
	var color_rect = ColorRect.new()
	color_rect.color = Color(0.14, 0.1, 0.2)
	color_rect.rect_size = get_viewport_rect().size
	add_child(color_rect)

	# Crea las cajas
	showBox()
	# Crea las etiquetas
	showLabels()
	# Crea el botón
	showButton()
	# Muestra Creditos e Información.
	showInfo()


func initGame():
	# Esconder interfaz.
	box_instanceAncho.hide()
	box_instanceAlto.hide()
	width_label.hide()
	height_label.hide()
	info_label.hide()
	button.hide()
	# Iniciar juego principal
	var game_instance = game_scene.instance()
	var gamePos
	# Tamaños mayores (No implementado)
	#if int(alto)*int(ancho) > 100:
	#	gamePos = center/(int(alto)*int(ancho)/50)
	#else:
	gamePos = Vector2(3,0)
	game_instance.setSize(alto, ancho)
	game_instance.set_position(gamePos)
	call_deferred("add_child", game_instance)

func showBox():
	# Crea las cajas
	box_instanceAncho = box_scene.instance()
	box_instanceAncho.initBox(center, -150, -130)
	add_child(box_instanceAncho)

	box_instanceAlto = box_scene.instance()
	box_instanceAlto.initBox(center, -150, -60)
	add_child(box_instanceAlto)

func showLabels():
	# Crea las etiquetas de tamaño
	width_label = Label.new()
	width_label.add_font_override("font", custom_font)
	width_label.text = "Ancho"
	add_child(width_label)

	height_label = Label.new()
	height_label.text = "Alto"
	height_label.add_font_override("font", custom_font)
	add_child(height_label)

	# Definir posición
	width_label.set_position(center + Vector2(70, -120))
	height_label.set_position(center + Vector2(70, -50))
	
func showButton():
	# Crea el botón para iniciar el juego
	button = Button.new()
	button.text = "Iniciar"
	button.connect("pressed", self, "botonApretado")
	add_child(button)
	# Define atributos
	button.set_position(center + Vector2(-50, 0))
	button.set_size(Vector2(100, 50))
	button.add_font_override("font", custom_font)

func showInfo():
	# Crea las etiquetas de tamaño
	info_label = Label.new()
	info_label.text = "Buscaminas Diseño.\nCreado Por Juan Aguilar\ny Carlos Sánchez \n\nIngrese tamaño\n(Max 10x10, Min 3x3)"
	info_label.add_font_override("font", custom_font)
	add_child(info_label)
	# Definir posición
	info_label.set_position(center + Vector2(-150, -260))

func botonApretado():
	# Función llamada al apretar botón.
	print("Iniciando.")
	# Obtener valores ingresados
	ancho = box_instanceAncho.getValue()
	alto = box_instanceAlto.getValue()
	# Iniciar juego
	initGame()
