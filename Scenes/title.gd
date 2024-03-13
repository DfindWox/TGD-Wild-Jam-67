extends Control

func _ready():
	# stuff before fade
	await Fade.fade_in()
	# stuff after fade
	print("hello world")


