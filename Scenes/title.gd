extends Control

func _ready():
	# stuff before fade
	await Fade.fade_in(0.2)
	# stuff after fade
	print("hello world")
	$VBoxContainer/BtnStart.grab_focus()




func _on_btn_start_pressed():
	await Fade.fade_out()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	await Fade.fade_in()

func _on_btn_credits_pressed():
	await Fade.fade_out(0.2)
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

func _on_btn_close_pressed():
	get_tree().quit()