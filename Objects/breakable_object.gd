class_name BreakableObject
extends CharacterBody2D
## Pode ser usado pra diversos tipos de destrutiveis
## seja impacto, fogo, etc etc.
## Use collision layers diferentes pra tipos diferentes de ataques.

var break_area : Area2D
var animation_player : AnimationPlayer

func _ready():
	break_area = $BreakDetectionArea
	break_area.area_entered.connect(_on_area_entered_breakarea)
	animation_player = $AnimationPlayer

## A animação "break" pode ser customizada pra cada caso.
func break_object():
	break_area.queue_free()
	animation_player.play("break")
	await animation_player.animation_finished
	queue_free()

func _on_area_entered_breakarea(area:Area2D):
	break_object()
