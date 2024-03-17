class_name LevelFinishZone
extends PlayerDetectionZone
## Use isso para definir onde a fase acaba e qual fase seguir em diante

## Arraste uma cena .tscn no export ao criar.
@export var next_scene_packed : PackedScene = null

func _ready():
	super()
	player_entered.connect(_on_player_entered)

func _on_player_entered(player):
	if player.has_parasite:
		go_to_next_scene(player)

func go_to_next_scene(player):
	#player.happy()
	# tocar efeito sonoro e particula legal
	AudioManager.play_sfx("stage_end.wav")
	
	# desativa o colisor
	get_child(0).set_deferred("disabled", true)
	
	player.happy()
	player.set_physics_process(false)
	await get_tree().create_timer(2.5).timeout
	await Fade.fade_out(1.0)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_packed(next_scene_packed)
	await Fade.fade_in()
