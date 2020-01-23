extends Control

signal game_over(time, words, mistakes)

export var words : Array
export var text : Array

export var manyKeys : bool setget _set_many_keys
export var isUpper : bool setget _set_is_upper

var _current_word : String
var _no_of_words : int
var _no_of_mistakes : int
var _start_time : int

func _ready() -> void:    
    $RightAudioPlayer.stream.loop = false
    $WrongAudioPlayer.stream.loop = false

    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard2x2.isText = true
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard3x3.isText = true
    
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard2x2.connect("key_pressed", self, "_on_key_pressed")
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard3x3.connect("key_pressed", self, "_on_key_pressed")
    
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard2x2.set_words(["one", "two", "three", "four"])
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard3x3.set_words(["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"])

func initialize_game() -> void:
    words = WordDb.pick_words(5)
    for i in range(words.size()):
        text.append(true)
    
func start_game() -> void:
    _no_of_mistakes = 0
    _no_of_words = words.size()
    _start_time = OS.get_unix_time()
    _update_time_label()
    $Timer.start()
    _next_word()

func _next_word() -> void:    
    _current_word = words[0]
    $MarginContainer/VBoxContainer/Control/TargetButton.word = _current_word
    words.remove(0)
    
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard2x2.isText = text[0]
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard3x3.isText = text[0]
    $MarginContainer/VBoxContainer/Control/TargetButton.isText = text[0] # TODO invert
    text.remove(0)
    
    var ow3 := WordDb.pick_other_words(3, _current_word)
    var ow8 := WordDb.pick_other_words(8, _current_word)

    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard2x2.set_words(WordDb.mix_words(ow3, _current_word))
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard3x3.set_words(WordDb.mix_words(ow8, _current_word))
    $MarginContainer/VBoxContainer/HBoxContainer/ProgressLabel.text = str(_no_of_words - len(words)) + " / " + str(_no_of_words)

func _set_many_keys(value : bool) -> void:
    manyKeys = value
    
    if value:
        $MarginContainer/VBoxContainer/KeyboardContainer.current_tab = 0
    else:
        $MarginContainer/VBoxContainer/KeyboardContainer.current_tab = 1
    
func _set_is_upper(value : bool) -> void:
    isUpper = value
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard2x2.isUpper = value
    $MarginContainer/VBoxContainer/KeyboardContainer/Keyboard3x3.isUpper = value

func _on_key_pressed(word : String) -> void:
    if word == _current_word:
        $AnimationPlayer.play("right")
        yield($AnimationPlayer, "animation_finished")
        
        if words.size() > 0:
            _next_word()
        else:
            var time_spent := OS.get_unix_time() - _start_time
            _update_time_label()
            $Timer.stop()
            emit_signal("game_over", time_spent, _no_of_words, _no_of_mistakes)
    else:
        _no_of_mistakes += 1
        $AnimationPlayer.play("wrong")
        yield($AnimationPlayer, "animation_finished")
        
func _play_right() -> void:
    $RightAudioPlayer.play()
    
func _play_wrong() -> void:
    $WrongAudioPlayer.play()

func _update_time_label() -> void:
    var elapsed : int = OS.get_unix_time() - _start_time
    var minutes : int = elapsed / 60
    var seconds : int = elapsed % 60
    $MarginContainer/VBoxContainer/HBoxContainer/TimeLabel.text = "%02d:%02d" % [minutes, seconds]

func _on_Timer_timeout() -> void:
    _update_time_label()
