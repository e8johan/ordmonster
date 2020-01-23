extends Control

signal key_pressed

export var isText : bool = false setget _set_is_text
export var isUpper : bool = false setget _set_is_upper

func _ready() -> void:
    $VBoxContainer/HBoxContainer/GameButton1.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer/GameButton2.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer/GameButton3.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer2/GameButton4.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer2/GameButton5.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer2/GameButton6.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer3/GameButton7.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer3/GameButton8.connect("key_pressed", self, "_on_key_press")
    $VBoxContainer/HBoxContainer3/GameButton9.connect("key_pressed", self, "_on_key_press")

func set_words(words : Array) -> void:
    assert(words.size() == 9)
    
    $VBoxContainer/HBoxContainer/GameButton1.word = words[0]
    $VBoxContainer/HBoxContainer/GameButton2.word = words[1]
    $VBoxContainer/HBoxContainer/GameButton3.word = words[2]
    $VBoxContainer/HBoxContainer2/GameButton4.word = words[3]
    $VBoxContainer/HBoxContainer2/GameButton5.word = words[4]
    $VBoxContainer/HBoxContainer2/GameButton6.word = words[5]
    $VBoxContainer/HBoxContainer3/GameButton7.word = words[6]
    $VBoxContainer/HBoxContainer3/GameButton8.word = words[7]
    $VBoxContainer/HBoxContainer3/GameButton9.word = words[8]

func _on_key_press(word : String) -> void:
    emit_signal("key_pressed", word)
    
func _set_is_text(value : bool) -> void:
    isText = value
    
    $VBoxContainer/HBoxContainer/GameButton1.isText = value
    $VBoxContainer/HBoxContainer/GameButton2.isText = value
    $VBoxContainer/HBoxContainer/GameButton3.isText = value
    $VBoxContainer/HBoxContainer2/GameButton4.isText = value
    $VBoxContainer/HBoxContainer2/GameButton5.isText = value
    $VBoxContainer/HBoxContainer2/GameButton6.isText = value
    $VBoxContainer/HBoxContainer3/GameButton7.isText = value
    $VBoxContainer/HBoxContainer3/GameButton8.isText = value
    $VBoxContainer/HBoxContainer3/GameButton9.isText = value

func _set_is_upper(value : bool) -> void:
    isUpper = value
    
    $VBoxContainer/HBoxContainer/GameButton1.isUpper = value
    $VBoxContainer/HBoxContainer/GameButton2.isUpper = value
    $VBoxContainer/HBoxContainer/GameButton3.isUpper = value
    $VBoxContainer/HBoxContainer2/GameButton4.isUpper = value
    $VBoxContainer/HBoxContainer2/GameButton5.isUpper = value
    $VBoxContainer/HBoxContainer2/GameButton6.isUpper = value
    $VBoxContainer/HBoxContainer3/GameButton7.isUpper = value
    $VBoxContainer/HBoxContainer3/GameButton8.isUpper = value
    $VBoxContainer/HBoxContainer3/GameButton9.isUpper = value
