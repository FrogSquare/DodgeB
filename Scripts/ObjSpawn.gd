extends Spatial

const OBJ1 = preload("res://Scenes/Obj/Obstacle1.tscn")

onready var player = Utils.get_main_node().get_node("MainLayer/Player")
onready var HUD = Utils.get_main_node().get_node("HUD")
onready var tween = get_node("Tween")

var past_pos = []

func _ready():
	randomize()
	past_pos = []
	pass

func _start_spawn():
	tween.stop_all()
	tween.set_repeat(true)
	
	var delay = global.SPAWN_DELAY
	for i in range(1, 5):
		tween.interpolate_callback(self, delay, "spawn_obstacle")
		delay += global.SPAWN_DELAY
	
	tween.interpolate_callback(self, tween.get_runtime(), "reset")
	tween.start()
	pass

func _stop_spawn():
	tween.stop_all()
	pass

func reset():
	past_pos.clear()
	past_pos = []
	
	HUD._score()
	pass

func on_obj_hits(hit_node, self_obj):
	if self_obj != null:
		if hit_node == Utils.get_main_node().get_node("MainLayer/Platform"):
			self_obj.collision_layer = global.PLATFORM_COLLISION_LAYER
		else:
			print("Hit Player")
		
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
	
