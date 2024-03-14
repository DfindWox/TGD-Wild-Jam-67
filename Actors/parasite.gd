extends Player

func skills():
	if Input.is_action_just_pressed("ui_accept"):
		take_over()

func take_over():
	print_debug("taking over")
	$AnimationPlayer.play("attack")
	pass

func _on_area_2d_body_entered(body):
	#if attack_area_has_enemy:
		#$AnimationPlayer.play("connect")
		#has_parasite = false
		#body.has_parasite = true
	pass
