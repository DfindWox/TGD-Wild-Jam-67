extends CharacterBody2D

enum { LEFT, RIGHT }

@export var push_speed : float = 16 # pixels por segundo
@export var gravity : float = 980 # p/s2

## usar a layer 12, "PUSH DETECTOR", na layer dessa area (sem mask)
## a hitbox do inimigo pra empurrar deve ser uma Area2D com mask 12
@export var push_area_left : Area2D
@export var push_area_right : Area2D

var push_area_left_active := false
var push_area_right_active := false


func _ready():
	push_area_left.area_entered.connect(_on_area_entered_pusharea.bind(LEFT))
	push_area_left.area_exited.connect(_on_area_exited_pusharea.bind(LEFT))
	push_area_right.area_entered.connect(_on_area_entered_pusharea.bind(RIGHT))
	push_area_right.area_exited.connect(_on_area_exited_pusharea.bind(RIGHT))

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	# pushing
	var hor_move : float = 0
	print("hormove:", hor_move)
	if push_area_left_active: hor_move += 1
	if push_area_right_active: hor_move -= 1
	hor_move *= push_speed
	velocity.x = move_toward(velocity.x, hor_move, delta*100)
	
	move_and_slide()

func _on_area_entered_pusharea(area:Area2D, left_or_right):
	match left_or_right:
		LEFT: push_area_left_active = true
		RIGHT: push_area_right_active = true

func _on_area_exited_pusharea(area:Area2D, left_or_right):
	match left_or_right:
		LEFT: push_area_left_active = false
		RIGHT: push_area_right_active = false
