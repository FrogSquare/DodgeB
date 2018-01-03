extends RigidBody

func _ready():
	gravity_scale = rand_range(0.5, 1)
	
	collision_mask = global.OBJECT_COLLISION_LAYER
	collision_layer = global.PLAYER_COLLISION_LAYER|global.PLATFORM_COLLISION_LAYER
	pass

