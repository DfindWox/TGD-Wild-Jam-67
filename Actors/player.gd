class_name Player
extends CharacterBody2D

@export var has_parasite:bool = false
@export var max_jumps : int = 1
@export var move_speed : float = 200.0
@export var jump_velocity : float = 200.0
@export var gravity : float = 980#ProjectSettings.get_setting("physics/2d/default_gravity")

var total_jumps : int = 0
var is_dead := false


## virtual, o codigo rodado quando o bixo não é possuido
func ai_behavior(_delta:float):
	pass

## virtual, codigo pra usar outras habilidades pelo parasita (tiro, voo) 
func player_skills(_delta:float):
	#print_debug("RAAWWNNNN")
	pass

func player_move(_delta): # delta não é usado ainda pois ta incluso em move_and_slide
	if Input.is_action_just_pressed("ui_up") and total_jumps < max_jumps:
		velocity.y = - jump_velocity
		total_jumps += 1
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

# func _process(delta):
#	pass

func _physics_process(delta):
	basic_physics(delta)
	if not is_dead:
		if has_parasite:
			player_move(delta)
			player_skills(delta)
		else:
			ai_behavior(delta)
	move_and_slide()

func kill():
	is_dead = true
	# play animation die
	await get_tree().create_timer(0.5).timeout
	if not has_parasite:
		queue_free()
	else:
		await Fade.fade_out()
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()

func basic_physics(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		velocity.y = 0
		total_jumps = 0
	# Handle jump.


