extends Player

var bullet_packed : PackedScene = load("res://Actors/shooter_bullet.tscn")

@onready var attack_timer : Timer = $AttackTimer


func player_skills(_delta:float):
	if Input.is_action_just_pressed("attack"):
		if attack_timer.is_stopped():
			attack_timer.start()
			shoot()

func shoot():
	var bullet : Node2D = bullet_packed.instantiate()
	bullet.set_source(self)
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.set_direction(is_facing_right)
	AudioManager.play_sfx("shoot.wav")
