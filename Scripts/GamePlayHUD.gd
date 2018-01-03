extends Node2D

onready var obj_spawner = Utils.get_main_node().get_node("MainLayer/ObjSpawn")

func _ready():
	pass

func _score():
	global.score += 1
	get_node("GamePlay/Score").text = str(global.score)
	pass

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		if not obj_spawner.tween.is_active():
			Utils.get_main_node().get_node("MainLayer/ObjSpawn")._start_spawn()
			
			get_node("MainMenu").visible = false
			get_node("GamePlay").visible = true
			set_process_input(false)
	pass