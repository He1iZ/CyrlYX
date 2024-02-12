extends Node2D

@export var start_angle: float = 0
@export var arc: float = 1
@export var revers: bool = false

var timer: float = Global.song_lenght

@onready var cur = get_node("../Cursor")


func _ready():
	cur.set_rotation_degrees(start_angle)
	print("Start_Angle_Degrees: ", cur.get_rotation_degrees())
	pass # Replace with function body.

func _physics_process(_delta):
	
	if revers == true:
		arc = arc * -1
		revers = false
	
	if timer > 0:
		timer = timer - 0.1
		print("Timer: ", timer)

	
	cur.set_rotation_degrees(cur.get_rotation_degrees() + arc)
	print("Angle Degrees: ", cur.get_rotation_degrees())
	print("Angle: ", arc)
	
	if timer <= 0:
		arc = 0
		print("Time is out!")
	pass


#func infostats():


	#pass
