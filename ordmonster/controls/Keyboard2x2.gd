extends Control

signal key_pressed

export var isText : bool = false setget _set_is_text
export var isUpper : bool = false setget _set_is_upper

func _ready() -> void:
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton1.connect("key_pressed", self, "_on_key_press")
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton2.connect("key_pressed", self, "_on_key_press")
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton3.connect("key_pressed", self, "_on_key_press")
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton4.connect("key_pressed", self, "_on_key_press")

func set_words(words : Array) -> void:
    assert(words.size() == 4)
    
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton1.word = words[0]
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton2.word = words[1]
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton3.word = words[2]
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton4.word = words[3] 

func _on_key_press(word : String) -> void:
    emit_signal("key_pressed", word)

func _set_is_text(value : bool) -> void:
    isText = value
    
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton1.isText = value
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton2.isText = value
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton3.isText = value
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton4.isText = value

func _set_is_upper(value : bool) -> void:
    isUpper = value
    
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton1.isUpper = value
    $MarginContainer/VBoxContainer/HBoxContainer/GameButton2.isUpper = value
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton3.isUpper = value
    $MarginContainer/VBoxContainer/HBoxContainer2/GameButton4.isUpper = value
