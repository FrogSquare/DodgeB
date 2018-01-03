extends RigidBody

const GRAVITY = 200
const PLAYER_WALK = 2

func _ready():
	axis_lock_angular_x = true
	axis_lock_angular_y = true
	axis_lock_angular_z = true
	
	collision_mask = global.PLAYER_COLLISION_LAYER
	pass

func _physics_process(delta):
	if get_colliding_bodies().size() > 0:
		var vel = 0
		if Input.is_key_pressed(KEY_RIGHT):
			vel = PLAYER_WALK
			get_node("Player").rotation_degrees.y = 90
		elif Input.is_key_pressed(KEY_LEFT):
			vel = -PLAYER_WALK
			get_node("Player").rotation_degrees.y = -90
		
		linear_velocity.x = vel*GRAVITY*delta
	pass
