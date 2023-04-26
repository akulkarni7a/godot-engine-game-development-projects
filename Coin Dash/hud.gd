extends CanvasLayer

signal start_game

func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)
	
func update_timer(value):
	$MarginContainer/TimeLabel.text = str(value)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageLabel.start()
	

func _on_message_timer_timeout():
	$MessageLabel.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$StartButton.show()
	$MessageLabel.text = "Coin Dash!"
	$MessageLabel.show()
	
