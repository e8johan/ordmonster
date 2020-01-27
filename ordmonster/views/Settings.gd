extends Control

signal back_clicked

var no_of_exercises : int = 10
var w2p : bool = true
var p2w : bool = true
var manyP : bool = true
var manyW : bool = false

func _ready() -> void:
    var f = File.new()
    if f.file_exists("user://om-settings.save"):
        f.open("user://om-settings.save", File.READ)
        var noe = f.get_var()
        _set_no_of_exercises(noe)
        var mode = f.get_var()
        if mode == 0:
            _on_W2PCheck_pressed()
        elif mode == 1:
            _on_P2WCheck_pressed()
        else:
            _on_WP2PWCheck_pressed()
        var p = f.get_var()
        if p == 1:
            $MarginContainer/VBoxContainer/HBoxContainer2/W49Check.pressed = true
        else:
            $MarginContainer/VBoxContainer/HBoxContainer2/W49Check.pressed = false
        p = f.get_var()
        if p == 1:
            $MarginContainer/VBoxContainer/HBoxContainer2/P49Check.pressed = true
        else:
            $MarginContainer/VBoxContainer/HBoxContainer2/P49Check.pressed = false
        f.close()
    else:        
        _set_no_of_exercises(10)
        _on_WP2PWCheck_pressed()
        $MarginContainer/VBoxContainer/HBoxContainer2/W49Check.pressed = false
        $MarginContainer/VBoxContainer/HBoxContainer2/P49Check.pressed = true

    _on_W49Check_toggled($MarginContainer/VBoxContainer/HBoxContainer2/W49Check.pressed)
    _on_P49Check_toggled($MarginContainer/VBoxContainer/HBoxContainer2/P49Check.pressed)

func _on_BackButton_pressed() -> void:
    var f = File.new()
    f.open("user://om-settings.save", File.WRITE)
    f.store_var(no_of_exercises)
    if $MarginContainer/VBoxContainer/HBoxContainer/W2PCheck.pressed:
        f.store_var(0)
    elif $MarginContainer/VBoxContainer/HBoxContainer/P2WCheck.pressed:
        f.store_var(1)
    else:
        f.store_var(2)
        if $MarginContainer/VBoxContainer/HBoxContainer2/W49Check.pressed:
            f.store_var(1)
        else:
            f.store_var(0)
        if $MarginContainer/VBoxContainer/HBoxContainer2/P49Check.pressed:
            f.store_var(1)
        else:
            f.store_var(0)
    f.close()
    
    emit_signal("back_clicked")

func _on_MinusButton_pressed() -> void:
    _set_no_of_exercises(no_of_exercises-1)

func _on_PlusButton_pressed() -> void:
    _set_no_of_exercises(no_of_exercises+1)

func _on_W2PCheck_pressed() -> void:
    $MarginContainer/VBoxContainer/HBoxContainer/W2PCheck.pressed = true
    $MarginContainer/VBoxContainer/HBoxContainer/P2WCheck.pressed = false
    $MarginContainer/VBoxContainer/HBoxContainer/WP2PWCheck.pressed = false
    w2p = true
    p2w = false

func _on_P2WCheck_pressed() -> void:
    $MarginContainer/VBoxContainer/HBoxContainer/W2PCheck.pressed = false
    $MarginContainer/VBoxContainer/HBoxContainer/P2WCheck.pressed = true
    $MarginContainer/VBoxContainer/HBoxContainer/WP2PWCheck.pressed = false
    w2p = false
    p2w = true

func _on_WP2PWCheck_pressed() -> void:
    $MarginContainer/VBoxContainer/HBoxContainer/W2PCheck.pressed = false
    $MarginContainer/VBoxContainer/HBoxContainer/P2WCheck.pressed = false
    $MarginContainer/VBoxContainer/HBoxContainer/WP2PWCheck.pressed = true
    w2p = true
    p2w = true

func _on_W49Check_toggled(button_pressed: bool) -> void:
    if button_pressed:
        $MarginContainer/VBoxContainer/HBoxContainer2/W49Check/TextureRect.texture = load("res://assets/images/9w.png")
        manyW = true
    else:
        $MarginContainer/VBoxContainer/HBoxContainer2/W49Check/TextureRect.texture = load("res://assets/images/4w.png")
        manyW = false

func _on_P49Check_toggled(button_pressed: bool) -> void:
    if button_pressed:
        $MarginContainer/VBoxContainer/HBoxContainer2/P49Check/TextureRect.texture = load("res://assets/images/9p.png")
        manyP = true
    else:
        $MarginContainer/VBoxContainer/HBoxContainer2/P49Check/TextureRect.texture = load("res://assets/images/4p.png")
        manyP = false

func _set_no_of_exercises(noe : int) -> void:
    if noe < 1:
        noe = 1
    if noe > 99:
        noe = 99
    no_of_exercises = noe
    $MarginContainer/VBoxContainer/HBoxContainer3/ExercisesLabel.text = str(noe)
