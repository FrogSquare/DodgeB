extends Node2D

onready var obj_spawner = Utils.get_main_node().get_node("MainLayer/ObjSpawn")

func _ready():
	get_node("Overlay").visible = true
	get_node("MainMenu").visible = true
	get_node("GameOver").visible = false
	get_node("GamePlay").visible = false
	get_node("GamePause").visible = false
	
	get_node("MainMenu/TapStart/AnimationPlayer").play("wobble")
	pass

func _score():
	global.score += 1
	get_node("GamePlay/Score").text = str(global.score)
	pass

func _start():
	get_node("GamePause/TapResume/AnimationPlayer").stop()
	get_node("GamePlay/Score").text = str(global.score)
	
	get_node("Overlay").visible = false
	get_node("MainMenu").visible = false
	get_node("GameOver").visible = false
	get_node("GamePause").visible = false
	
	get_node("GamePlay").visible = true
	
	set_process_input(false)
	pass

func _resume():
	get_node("GamePause/TapResume/AnimationPlayer").stop()
	
	get_node("Overlay").visible = false
	get_node("MainMenu").visible = false
	get_node("GameOver").visible = false
	get_node("GamePause").visible = false
	
	get_node("GamePlay").visible = true
	pass

func _pause():
	get_node("GamePause/TapResume/AnimationPlayer").stop()
	get_node("GamePause/TapResume/AnimationPlayer").play("wobble")
	
	get_node("Overlay").visible = true
	get_node("MainMenu").visible = false
	get_node("GameOver").visible = false
	get_node("GamePlay").visible = false
	
	get_node("GamePause").visible = true
	pass

func _game_over():
	# Update your database with your score and some :)
	get_node("GamePause/TapResume/AnimationPlayer").stop()
	get_node("GameOver/TapRetry/AnimationPlayer").play("wobble")

	get_node("Overlay").visible = true
	get_node("MainMenu").visible = false
	get_node("GamePlay").visible = false
	get_node("GamePause").visible = false
	
	get_node("GameOver").visible = true
	
	set_process_input(true)
	pass
	
