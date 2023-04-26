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
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playTime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
	
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


func _on_game_timer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()
		
func game_over():
	playing = false
	$GamerTime.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()

func _on_player_pickup():
	score += 1
	$HUD.update_score(score)
	

func _on_player_hurt():
	game_over()
