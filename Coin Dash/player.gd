extends Area2D
signal pickup
signal hurt

@export var speed: int 
var velocity = Vector2()
var screenSize = Vector2(480,720)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite2D.animation = "idle"
	
func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false) #this stops the _process from running - can no longer take user input

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	position += velocity * delta
	position.x = clamp(position.x,0,screenSize.x)
	position.y = clamp(position.y,0,screenSize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h =  velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
