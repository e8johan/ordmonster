extends Control

signal play_clicked
signal settings_clicked
signal quit_clicked

func _ready() -> void:
    if OS.get_name() == "HTML5":
        $MarginContainer/VBoxContainer/ExitButton.visible = false

func _on_PlayButton_pressed() -> void:
    emit_signal("play_clicked")

func _on_SettingsButton_pressed() -> void:
    emit_signal("settings_clicked")

func _on_ExitButton_pressed() -> void:
    emit_signal("quit_clicked")
