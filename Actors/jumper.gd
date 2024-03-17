extends Player

@export var air_move_speed : float = 200
@export var ground_move_speed : float = 0
@export var jump_weakening_mod : float = 0.7

@onready var ai_jump_timer : Timer = $AIJumpTimer

func _process(delta):
	%Sprite2D.flip_h = not is_facing_right
	
	if is_on_floor():
		move_speed = ground_move_speed
	else:
		move_speed = air_move_speed

func ai_behavior(_delta):
	if is_on_floor():
		velocity.x = 0
	if ai_jump_timer.is_stopped():
		# jump
		do_ai_jump()

func do_ai_jump():
	ai_jump_timer.start()
	is_facing_right = not is_facing_right
	velocity.y = - jump_velocity * 0.3
	velocity.x = air_move_speed * 0.3
	if not is_facing_right: 
		velocity.x *= -1
	await get_tree().create_timer(0.6).timeout
	if has_parasite: return
	velocity.y = - jump_velocity * 0.2

func adjust_jump_velocity():
	var factor = pow(jump_weakening_mod, total_jumps-1)
	velocity.y = - jump_velocity * factor
	#print(total_jumps, " ", factor, velocity.y)
