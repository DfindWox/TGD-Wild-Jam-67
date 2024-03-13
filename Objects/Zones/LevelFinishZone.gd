class_name LevelFinishZone
extends PlayerDetectionZone
## Use isso para definir onde a fase acaba e qual fase seguir em diante

## Arraste uma cena .tscn no export ao criar.
@export var next_scene_packed : PackedScene = null

func _ready():
	player_entered.connect(_on_player_entered)

func _on_player_entered(player):
	go_to_next_scene(player)

func go_to_next_scene(player):
	# player.commemorate()
	# tocar efeito sonoro e particula legal
	await get_tree().create_timer(2.0)
	# player.walk_to_the_right()
	await Fade.fade_out(1.5)
	await get_tree().create_timer(0.5)
	get_tree().change_scene_to_packed(next_scene_packed)
