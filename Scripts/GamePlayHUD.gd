extends Node2D

onready var obj_spawner = Utils.get_main_node().get_node("MainLayer/ObjSpawn")

func _ready():
	pass

func _score():
	global.score += 1
	get_node("GamePlay/Score").text = str(global.score)
	pass

func _start():
	Utils.get_main_node().get_node("MainLayer/ObjSpawn")._start_spawn()
	
	global.gamestarted = true
	get_node("MainMenu").visible = false
	get_node("GameOver").visible = false
	get_node("GamePlay").visible = true
	
	set_process_input(false)
	pass

func _game_over():
	Utils.get_main_node().get_node("MainLayer/ObjSpawn")._stop_spawn()
	
	global.gamestarted = false
	get_node("MainMenu").visible = false
	get_node("GamePlay").visible = false
	get_node("GameOver").visible = true
	
	set_process_input(true)
	pass

func _input(event):
	if (event is InputEventMouseButton and event.is_pressed()) or \
						event is InputEventKey and event.scancode == KEY_SPACE:
		if not obj_spawner.tween.is_active():
			if get_node("MainMenu").visible: _start()
			if get_node("GameOver").visible: _start()
	pass
	
