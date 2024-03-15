extends CharacterBody2D

@export var speed : float = 100

func set_source(source:Player):
	$DeathZone.source = source

func set_direction(is_facing_right):
	if is_facing_right:
		velocity.x = speed
	else:
		velocity.x = -speed

func _physics_process(_delta):
	move_and_slide()

func destroy():
	queue_free()

func _on_death_zone_player_killed():
	destroy()

func _on_death_zone_body_entered(body):
	if body is TileMap:
		destroy()

func _on_break_area_area_entered(_area):
	destroy()
