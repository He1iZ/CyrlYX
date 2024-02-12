extends Sprite2D

var note = self
var parent = get_parent()
var noteTexture = load("res://icon.svg")
var notesArrayIndex := 0




func _ready():
	note.set_texture(noteTexture)



func _process(_delta):
	move_note(Vector2(0,0),Vector2(1000,1000),1000000)
	pass

func move_note(from:Vector2, to:Vector2, time:int):
	var timeCurrent  := Time.get_ticks_msec()
	var timePreviousCall := 0
	var path := Vector2.ZERO
	var step := Vector2.ZERO
	
	path = to - from
	step = path/time
	note.translate(step*(timeCurrent-timePreviousCall))
	timePreviousCall = timeCurrent
	pass
