extends Player

var push_area_count : int = 0

func _process(delta):
	# animations
	%Sprite2D.flip_h = not is_facing_right
	
	if push_area_count > 0 and velocity.y != 0:
		if %AnimationPlayer.current_animation in ["jump", ""]:
			$AnimationPlayer.play("pushStart")


func _on_push_area_area_entered(_body):
	if not is_dead:
		push_area_count += 1
		$AnimationPlayer.play("pushStart")

func _on_push_area_area_exited(_body):
	if not is_dead:
		push_area_count -= 1
		$AnimationPlayer.play("idle")
