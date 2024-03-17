extends Player

var bullet_packed : PackedScene = load("res://Actors/shooter_bullet.tscn")

@onready var attack_timer : Timer = $AttackTimer

func _process(_delta):
	# animations
	%Sprite2D.flip_h = not is_facing_right
	$RayCast2D.scale.x = 1 if is_facing_right else -1

func ai_behavior(_delta):
	print('check')
	if attack_timer.is_stopped():
		var collided_body = $RayCast2D.get_collider()
		if collided_body and collided_body is Player and collided_body.has_parasite and $AttackDelay.is_stopped():
			$AttackDelay.start()
		else: #attempt failed
			$AnimationPlayer.play("land")
			attack_timer.start()

func player_skills(_delta:float):
	if Input.is_action_just_pressed("attack"):
		if attack_timer.is_stopped():
			attack_timer.start()
			$AnimationPlayer.play("shoot")

func shoot():
	var bullet : Node2D = bullet_packed.instantiate()
	bullet.set_source(self)
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.set_direction(is_facing_right)
	AudioManager.play_sfx("shoot.wav")




func _on_attack_delay_timeout():
	$AnimationPlayer.play("shoot")
	attack_timer.start()
