extends TextureButton

signal key_pressed

export var word : String = "" setget _set_word
export var isText : bool = true setget _set_is_text
export var isUpper : bool = false setget _set_is_upper

func _ready() -> void:
    pass
    
func _set_is_upper(value : bool) -> void:
    isUpper = value
    _update_text()

func _set_word(value : String) -> void:
    word = value
    _update_text()
    $MarginContainer/QuizImage.texture = load(WordDb.path_from_word(word))

func _update_text() -> void:
    $QuizText.text = WordDb.format_word(word, isUpper)

func _set_is_text(value : bool) -> void:
    isText = value
        
    $QuizText.visible = isText
    $MarginContainer/QuizImage.visible = !isText

func _on_GameButton_pressed() -> void:
    emit_signal("key_pressed", word)
