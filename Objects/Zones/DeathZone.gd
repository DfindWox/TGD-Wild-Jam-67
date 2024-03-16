class_name DeathZone
extends PlayerDetectionZone
## Use isso para definir zonas Out of Bounds ou Lava ou Ácido ou algo assim

signal player_killed

## usado pra ignorar da dano na criatura que criou o efeito
var source : Player = null

func _ready():
	super()
	player_entered.connect(_on_player_entered)

func _on_player_entered(body:Node2D):
	if source and source == body: return
	
	kill_player(body)

func kill_player(player:Player):
	if not player.is_dead:
		player.kill()
		player_killed.emit()
