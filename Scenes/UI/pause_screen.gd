extends CanvasLayer


func _ready():
	visible = false
	AudioManager.install_ui(get_child(0))


func open():
	get_tree().paused = true
	visible = true
	%BtnContinue.grab_focus()


func close():
	get_tree().paused = false
	visible = false


func _unhandled_input(event):
	if Input.is_action_just_pressed("pause"):
		if not visible:
			open()
			pass
		else:
			close()
			pass


func _on_btn_continue_pressed():
	close()
	%BtnContinue.release_focus()
	pass


func _on_btn_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	await Fade.fade_in()
