class_name ScoreManager extends Node

static var Instance: ScoreManager

signal beat_triggered(score: Note.SCORE_STATE)

var current_score: int

func _enter_tree() -> void:
	Instance = self

func _exit_tree() -> void:
	Instance = null


func _on_beat_triggered(score: Note.SCORE_STATE) -> void:
	current_score += score
	print("Current Score: " + str(current_score))
