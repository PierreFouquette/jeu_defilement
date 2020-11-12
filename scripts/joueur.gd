extends KinematicBody2D

onready var anim = $AnimatedSprite
onready var vitalite = $coeur
onready var vitalite2 = $coeur2
onready var vitalite3 = $coeur3
export(int) var currentframe
var vitesse = 200
var gravity = 1000
var impulsion = -500
var jumping = false
var velocity = Vector2()
var vie = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	_anim_player()
	restant()
	

func _physics_process(delta):
	_ctrl_player()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0,-1))

func _anim_player():
	if Input.is_action_pressed("ui_right"):
		anim.flip_h = false
		anim.play("run")
	elif Input.is_action_pressed("ui_left"):
		anim.flip_h = true
		anim.play("run")
	else:
		anim.flip_h = false
		anim.play("idle")

func _ctrl_player():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_select")
	
	velocity.x = 0
	if right:
		velocity.x += vitesse
	if left:
		velocity.x -= vitesse
	if jump and is_on_floor():
		jumping = true
		velocity.y = impulsion


func _on_mort_body_entered(body):
	position.x = 64
	position.y = 344
	vie -=1


func _on_victoire_body_entered(body):
	get_tree().change_scene("res://scenes/fin.tscn")

func restant():
	if vie == 2:
		currentframe=1
		vitalite3.frame = currentframe
	elif vie == 1:
		currentframe=1
		vitalite2.frame = currentframe
	elif vie == 0:
		currentframe=1
		vitalite.frame = currentframe
		get_tree().change_scene("res://scenes/fin.tscn")
