extends Control

func _ready():
	# stuff before fade
	await Fade.fade_out(0.001)
	AudioManager.play_music("1-stargazing_0.mp3")
	await Fade.fade_in(0.2)
	AudioManager.install_ui(self)
	# stuff after fade
	print("hello world")
	$VBoxContainer/BtnStart.grab_focus()




func _on_btn_start_pressed():
	await Fade.fade_out()
	AudioManager.stop_music()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	AudioManager.play_music("2-garden_0.mp3")
	await Fade.fade_in()
	

func _on_btn_credits_pressed():
	await Fade.fade_out(0.2)
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

func _on_btn_close_pressed():
	get_tree().quit()
