extends Node2D

# Declarar una variable para almacenar el texto ingresado en el LineEdit
var entered_text = "10"
var line_edit = LineEdit.new()
var custom_font = DynamicFont.new()

func _ready():
	pass
	
func initBox(center, x, y):
	# Inicializa la fuente.
	custom_font.font_data = load("res://Fonts/PixelA.ttf")
	
	# Crear un nodo CanvasLayer y agregarlo como hijo de este nodo
	var canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)

	# Crear un nodo LineEdit y agregarlo como hijo del CanvasLayer
	canvas_layer.add_child(line_edit)

	# Establecer las propiedades del LineEdi
	line_edit.rect_position = (center + Vector2(x, y)) # Ubicamos el cuadro
	line_edit.placeholder_text = "Ingrese el valor" # Ponemos el mensaje Placeholder
	line_edit.add_font_override("font", custom_font)
	line_edit.rect_size = Vector2(200, 50) # Ajustamos el tamaño

	# Conectar la señal "text_changed" del LineEdit a un método que guarda su contenido en la variable
	line_edit.connect("text_changed", self, "_on_text_changed")

func _on_text_changed(new_text):
	# Convertir
	var new_int = int(new_text)
	if new_int != 0:
		# Max
		if new_int > 10:
			new_int = 10
		# Min
		if new_int < 3:
			new_int = 3
		# Guardar el nuevo texto ingresado en el LineEdit en la variable
		entered_text = new_int
	else:
		# Control de errores. Devuelta a valor por defecto.
		entered_text = 10

func getValue():
	return entered_text
	
func hide():
	line_edit.hide()
