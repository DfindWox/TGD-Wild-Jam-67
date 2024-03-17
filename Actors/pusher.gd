extends Player

var push_area_count : int = 0
@export var move_speed_mod : float = 0.2
var saw_enemy : bool = false
func _process(delta):
	# animations
	%Sprite2D.flip_h = not is_facing_right
	$RayCast2D.scale.x = 1 if is_facing_right else -1
	$EdgeRay.position.x = 13 if is_facing_right else -13
	if push_area_count > 0 and velocity.y != 0:
		if %AnimationPlayer.current_animation in ["jump", ""]:
			$AnimationPlayer.play("pushStart")
func ai_behavior(_delta):
	if saw_enemy and $EdgeRay.is_colliding():
		velocity.x = move_speed * move_speed_mod * $RayCast2D.scale.x
	else:
		velocity.x = 0
	var collided_body = $RayCast2D.get_collider()
	if collided_body and collided_body is Player and collided_body.has_parasite:
		saw_enemy = true
		$AggroTimer.start()

func _on_push_area_area_entered(_body):
	if not is_dead:
		push_area_count += 1
		$AnimationPlayer.play("pushStart")

func _on_push_area_area_exited(_body):
	if not is_dead:
		push_area_count -= 1
		$AnimationPlayer.play("idle")


func _on_aggro_timer_timeout():
	saw_enemy = false


func _on_turn_timer_timeout():
	if not saw_enemy and not has_parasite:
		is_facing_right = not is_facing_right
