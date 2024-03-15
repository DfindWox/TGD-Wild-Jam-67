class_name DeathZone
extends PlayerDetectionZone
## Use isso para definir zonas Out of Bounds ou Lava ou Ácido ou algo assim

func _ready():
	player_entered.connect(_on_player_entered)

func _on_player_entered(body:Node2D):
	kill_player(body)

func kill_player(player):
	# player.kill()
	await get_tree().create_timer(0.5)
	await Fade.fade_out()
	await get_tree().create_timer(0.5)
	get_tree().reload_current_scene()
