extends Control

signal back_clicked

func _on_BackButton_pressed() -> void:
    emit_signal("back_clicked")
