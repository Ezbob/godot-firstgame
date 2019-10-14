extends CanvasLayer

signal start_game

var highScore: int = 0

func show_message(text: String) -> void:
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over() -> void:
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the\nCreeps"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)
	if (score > highScore):
		highScore = score
		$HighScoreLabel.text = "Highscore: " + str(score)

func _on_MessageTimer_timeout() -> void:
	$MessageLabel.hide()


func _on_StartButton_pressed() -> void:
	$StartButton.hide()
	$HighScoreLabel.hide()
	emit_signal("start_game")
