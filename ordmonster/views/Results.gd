extends Control

signal back_clicked

export var time_seconds : int
export var words : int
export var mistakes : int

func _on_BackButton_pressed() -> void:
    emit_signal("back_clicked")
    
func update_view() -> void:
    if mistakes == 0:
        $MarginContainer/VBoxContainer/EncourageLabel.text = tr("RESULT_1")
    elif mistakes < words / 4:
        $MarginContainer/VBoxContainer/EncourageLabel.text = tr("RESULT_2")
    elif mistakes < words:
        $MarginContainer/VBoxContainer/EncourageLabel.text = tr("RESULT_3")
    else:
        $MarginContainer/VBoxContainer/EncourageLabel.text = tr("RESULT_4")
            
    $MarginContainer/VBoxContainer/ResultLabel.text = str(words) + " " + tr("RESULT_FROM") + " " + str(words+mistakes) + " " + tr("RESULT_RIGHT")
    
    var minutes : int = time_seconds / 60
    var seconds : int = time_seconds % 60
    $MarginContainer/VBoxContainer/TimeLabel.text = tr("RESULT_TIME") + ": %02d:%02d" % [minutes, seconds]