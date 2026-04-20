class_name ScoreManager extends Node

static var Instance: ScoreManager

signal beat_triggered(score: Note.SCORE_STATE)

var current_score: int

var current_combo := 0
var best_combo := 0
var perfect_hits := 0

func _enter_tree() -> void:
	Instance = self

func _exit_tree() -> void:
	Instance = null
	
func _ready() -> void:
	Conductor.Instance.track_changed.connect(reset_score)

func _on_beat_triggered(score: Note.SCORE_STATE) -> void:
	current_score += score
	
	if score == Note.SCORE_STATE.PERFECT:
		perfect_hits += 1
		current_combo += 1
		best_combo = max(best_combo, current_combo)
	else:
		current_combo = 0

func reset_score(_menu: Menu) -> void:
	current_score = 0
