extends Node

@export var Coin: PackedScene
@export var playTime: int 

var level
var score
var time_left
var screenSize
var playing = false

func _ready():
	randomize()
	screenSize = get_viewport().get_visible_rect().size
	$Player.screenSize = screenSize
	$Player.hide()
	new_game()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playTime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	
func spawn_coins():
	for i in range(4+level):
		var c = Coin.instantiate()
		$CoinContainer.add_child(c)
		c.screenSize = screenSize
		c.position = Vector2(randf_range(0,screenSize.x),randf_range(0,screenSize.y))

func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()
