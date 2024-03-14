extends Control

func _ready():
	await Fade.fade_in(0.2)
	$BtnReturn.grab_focus()

func _on_btn_return_pressed():
	await Fade.fade_out(0.2)
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
