extends Node

signal fade_finished
var fade_rect: ColorRect

#DEBUG
#func _input(event):
	#if Input.is_action_just_pressed("ui_cancel"):
		#await Fade.fade_out()
		#print("a")

func fade_in(duration:=0.5):
	var tween = create_tween()
	tween.tween_property(fade_rect, "material:shader_parameter/circle_size", 0, 0)
	tween.tween_property(fade_rect, "material:shader_parameter/circle_size", 1.05, duration)
	tween.tween_callback(_emit_fade_finished)
	await fade_finished

func fade_out(duration:=0.5):
	var tween = create_tween()
	tween.tween_property(fade_rect, "material:shader_parameter/circle_size", 1.05, 0)
	tween.tween_property(fade_rect, "material:shader_parameter/circle_size", 0, duration)
	tween.tween_callback(_emit_fade_finished)
	await fade_finished

func _emit_fade_finished():
	fade_finished.emit()

func _ready():
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 10
	add_child(canvas_layer)
	
	#fade_rect = ColorRect.new()
	#fade_rect.color = Color.BLACK
	#fade_rect.size = Vector2(1920,1080)
	fade_rect = load("res://Scenes/UI/fade_color_rect.tscn").instantiate()
	canvas_layer.add_child(fade_rect)
	#fade_rect.scale.x = 0
