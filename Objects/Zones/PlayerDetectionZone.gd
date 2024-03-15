class_name PlayerDetectionZone
extends Area2D
## Classe genérica pra poder reusar
## Também é possível usar uma collision layer apenas do player.

signal player_entered

func _ready():
	body_entered.connect(_on_body_entered)

## Falta mudar isso ainda, como detectar se é o player entrando aqui?
func is_body_player(body):
	
	if body.is_in_group("PLAYER"): return true
	if body is Player and body.has_parasite: return true
	#if body is Player: return true
	return false

func _on_body_entered(body:Node2D):
	if is_body_player(body):
		player_entered.emit(body)
