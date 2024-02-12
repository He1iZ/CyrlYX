extends Node2D

# Взятие нод по ОТНОСИТЕЛЬНОМУ пути
@onready var canvas = self
@onready var cursor = get_node("../Cursor")

# Параметры сетки
@onready var center := Vector2(cursor.get_position().x, cursor.get_position().y)
var radius := 300.0
var sections := 16
var angle := 360.0/sections
var crossectionLines := 4
var linesArray := []

var colorsArray := [Color.WHITE,Color.RED,Color.BLUE,Color.YELLOW]
var colorsAmount := colorsArray.size()
var lineDarkness := 0.3
var lineThickness := 0.5

# Вращение стрелки 
var cursorSpeed := 600.0
var cursorRotation := 0.0

# Ноты
var notesArray := []

# Тестовые параметры
@export var GridTest: bool = false
@export var revers: bool = false



#func get_time():
	#var ticks = Time.get_ticks_msec()


func grid_create():

	var line := Vector2()
	var lineIndex := 0


	while lineIndex < sections:
		line = Vector2.from_angle(deg_to_rad(angle)*lineIndex)*radius
		linesArray.push_back(line)
		lineIndex+=1
	pass


func _draw():

	var lineColor := Color()
	var colorIndex := 0
	var colorsQueue := []
	var colorsQueueSize := 0
	
	var lineIndex := 0


# Разбивка массива цветов и запись в очередь цветов
	while colorIndex < sections:
		colorsQueue.push_back(colorsArray[colorsQueueSize-colorsAmount*(colorsQueueSize/colorsAmount)])
		colorIndex+=crossectionLines
		colorsQueueSize+=1


# Отрисовка сетки
	while lineIndex < sections:
		lineColor = colorsQueue[lineIndex-colorsQueueSize*(lineIndex/colorsQueueSize)]
		canvas.draw_line(center,center+linesArray[lineIndex],lineColor.darkened(lineDarkness),lineThickness)
		lineIndex+=1


func cursor_rotate():
	cursorRotation+=deg_to_rad(cursorSpeed)
	cursor.set_rotation_degrees(cursorRotation)


func random_spawner():
	var rng = RandomNumberGenerator.new()
	var random = rng.randi_range(0,sections)
	note_spawn(center+linesArray[random-1])


func note_spawn(notePosition:Vector2):
	var note = load("res://scenes/note.tscn").instantiate()
	canvas.add_child(note)
	note.translate(notePosition)
	notesArray.push_back(note)
	note.move_note(notePosition,center,10000)
	pass

func revers_speed(cursorRotation):
	cursorRotation = cursorRotation * -1
	print("cursorRotation = ", cursorRotation)
	revers = false


func _ready():
	print("Координаты: ", cursor.get_position().x, cursor.get_position().y)
	print("Center", center)
	grid_create()
	#random_spawner()

func  _process(_delta):
	if revers == true:
		revers_speed(cursorRotation)
	cursor_rotate()

	if GridTest == true:
		grid_create()
		queue_redraw()
		GridTest = false
