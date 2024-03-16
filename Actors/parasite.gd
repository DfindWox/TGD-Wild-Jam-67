class_name Parasite
extends Player
## usar o class name só para checar se essa cena é parasita ou não

var is_taking_over := false
var is_facing_right := false

var takeover_detection_count : int = 0

## vazio, parasita n sai dele mesmo
func detach_parasite():
	pass

func _ready():
	has_parasite = true

func _process(_delta):
	if velocity.x > 0:
		is_facing_right = true
	elif velocity.x < 0:
		is_facing_right = false
	
	# show popup
	%AttackArea.scale.x = 1 if is_facing_right else -1
	$Sprite2D.scale.x = 1 if is_facing_right else -1
	%TakeOverDetectionArea.scale.x = 1 if is_facing_right else -1
	if takeover_detection_count > 0:
		%TakeOverLabel.visible = true
		%TakeOverLabel.global_position = $AttackArea/AttackCollision.global_position
		%TakeOverLabel.global_position += Vector2(0, -32) - %TakeOverLabel.pivot_offset
	else:
		%TakeOverLabel.visible = false

func _physics_process(delta):
	if is_taking_over:
		basic_physics(delta)
		move_and_slide() # só move, nao aceita input
	else:
		super(delta) # chama a função da classe Player

func player_skills(_delta):
	if not is_taking_over and Input.is_action_just_pressed("take_over"):
		attempt_take_over()

func attempt_take_over():
	$AnimationPlayer.play("attemptTakeOver")
	pass

func do_take_over(body:Player):
	is_taking_over = true
	$CollisionShape2D.set_deferred("disabled", true)
	
	velocity.x = move_speed * (1 if is_facing_right else -1) * 0.5
	velocity.y = -jump_velocity * 0.5
	move_and_slide()
	
	await get_tree().create_timer(0.2).timeout
	if is_dead: return
	body.has_parasite = true
	var camera = get_node_or_null("GameCamera")
	if camera:
		remove_child(camera)
		body.add_child(camera)
		camera.position = Vector2.ZERO
	queue_free()

# Apenas objetos na layer 9: ENEMY podem entrar
func _on_area_2d_body_entered(body):
	if is_taking_over: return
	if not body is Player: return
	if body == self: return
	print(body)
	# if not, try to take over
	do_take_over(body)

# Apenas objetos na layer 9: ENEMY podem entrar
func _on_take_over_detection_area_body_entered(body):
	takeover_detection_count += 1

func _on_take_over_detection_area_body_exited(body):
	takeover_detection_count -= 1
