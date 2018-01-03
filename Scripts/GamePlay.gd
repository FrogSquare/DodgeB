extends Node

func _ready():
	get_node("MainLayer/Platform").collision_mask = global.PLATFORM_COLLISION_LAYER
	get_node("MainLayer/Platform").collision_layer =\
	global.PLAYER_COLLISION_LAYER|global.OBJECT_COLLISION_LAYER
	pass
