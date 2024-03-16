class_name Player
extends CharacterBody2D

var parasite_scene_packed : PackedScene = load("res://Actors/parasite.tscn")

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
		# parasita sair do bixo
		if has_parasite and Input.is_action_just_pressed("take_over"):
			detach_parasite()
	else:
		velocity.x = 0
	move_and_slide()

func detach_parasite():
	has_parasite = false
	var parasite = parasite_scene_packed.instantiate()
	get_tree().current_scene.add_child(parasite)
	parasite.global_position = global_position + Vector2(0, -16)
	parasite.velocity.y = -100
	parasite.velocity.x = 100 * [-1,1].pick_random()
	parasite.is_taking_over = true
	await get_tree().create_timer(0.5).timeout
	parasite.is_taking_over = false

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
		await Fade.fade_in()

func basic_physics(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		velocity.y = 0
		total_jumps = 0
	# Handle jump.


