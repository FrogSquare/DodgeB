extends Node

func _ready():
	get_node("MainLayer/Platform").collision_mask = global.PLATFORM_COLLISION_LAYER
	get_node("MainLayer/Platform").collision_layer =\
	global.PLAYER_COLLISION_LAYER|global.OBJECT_COLLISION_LAYER
	
	set_process_unhandled_key_input(false)
	pass

func _start():
	get_node("MainLayer/ObjSpawn")._start_spawn()
	
	global.score = 0
	global.gamestarted = true
	
	get_node("HUD")._start()
	set_process_unhandled_key_input(true)
	pass

func _pause():
	PhysicsServer.set_active(false)
	
	get_node("HUD")._pause()
	get_node("MainLayer/ObjSpawn")._stop_spawn()
	pass

func _resume():
	PhysicsServer.set_active(true)
	
	get_node("HUD")._resume()
	get_node("MainLayer/ObjSpawn")._start_spawn()
	pass

func _game_over():
	get_node("MainLayer/ObjSpawn")._stop_spawn()
	
	global.gamestarted = false
	
	get_node("HUD")._game_over()
	set_process_unhandled_key_input(false)
	pass

func _unhandled_key_input(event):
	if not global.gamestarted: return
	
	if Input.is_key_pressed(KEY_ESCAPE):
		if get_node("HUD/GamePause").visible: _resume()
		else: _pause()
	pass

func _input(event):
	if (event is InputEventMouseButton and event.is_pressed()) or \
					event is InputEventKey and event.scancode == KEY_SPACE:
		if not global.gamestarted:
			if get_node("HUD/MainMenu").visible: _start()
			if get_node("HUD/GameOver").visible: _start()
	pass
	
