extends Control

signal back_clicked

export var time_seconds : int
export var words : int
export var mistakes : int

func _on_BackButton_pressed() -> void:
    emit_signal("back_clicked")