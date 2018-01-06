extends Spatial

const OBJ1 = preload("res://Scenes/Obj/Obstacle1.tscn")

onready var player = Utils.get_main_node().get_node("MainLayer/Player")
onready var HUD = Utils.get_main_node().get_node("HUD")
onready var tween = get_node("Tween")

var past_pos = []

func _ready():
	randomize()
	past_pos = []
	
	set_process(false)
	pass

func _start_spawn():
	if tween.get_runtime() == 0:
		tween.stop_all()
		tween.set_repeat(true)
		
		var delay = global.SPAWN_DELAY
		for i in range(1, 5):
			tween.interpolate_callback(self, delay, "spawn_obstacle")
			delay += global.SPAWN_DELAY
		
		tween.interpolate_callback(self, tween.get_runtime(), "reset")
		tween.start()
	else: tween.resume_all()
	pass

func _stop_spawn():
	tween.reset_all()
	tween.stop_all()
	set_process(false)
	pass

func reset():
	if global.gamestarted:
		past_pos.clear()
		past_pos = []
		
		set_process(true)
		
		tween.resume_all()
		HUD._score()
	pass

func on_obj_hits(hit_body, self_obj):
	if self_obj != null:
		if hit_body == Utils.get_main_node().get_node("MainLayer/Player"):
			global.gamestarted = false
			for child in get_children():
				if child is RigidBody:
					if child.get_colliding_bodies().size() == 0:
						child.queue_free()
			
			Utils.get_main_node()._game_over()
		else:
			self_obj.collision_layer = global.PLATFORM_COLLISION_LAYER
		
		var t = self_obj.get_node("Timer")
		if not t.is_connected("timeout", self_obj, "queue_free"):
			t.connect("timeout", self_obj, "queue_free")
		
		t.wait_time = global.SPAWN_DELAY/2
		t.one_shot = true
		t.start()
		# Need to add some broken locks (maybe later...)
	pass

func spawn_obstacle():
	var ppos = Utils.get_main_node().get_node("MainLayer/Player").translation
	for i in range(3):
		var randX = randi() % global.PLATFORM_WIDTH
		var r = randi() % 10 + 1
		
		if r > 5: randX = -randX
		if randX == -0: randX = 0
		
		var try = 0
		while past_pos.find(randX) != -1:
			if r > 5: randX = randi() % global.PLATFORM_WIDTH
			else: randX = -(randi() % global.PLATFORM_WIDTH)
			
			if try > global.MAX_SPAWN_TRY: return
			try += 1
		
		var obj = OBJ1.instance()
		add_child(obj)
		
		past_pos.append(randX)
		
		obj.translation.x = randX
		obj.connect("body_entered", self, "on_obj_hits", [obj])
	pass

func _process(delta):
	if get_child_count() <= 1:
		tween.resume_all()
		set_process(false)
	pass
	

