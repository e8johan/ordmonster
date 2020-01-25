extends Node
class_name Words

var _words : Array = Array()

# Words are extracted from the file names in assets/images/words/*.png.
# The words are then fed to the translation system as WORD_foo, where foo would be from foo.png.
# The reason for this is that non-ascii characters are not supported among the assets.

func _init() -> void:
    var dir = Directory.new()
    if dir.open("res://assets/images/words") == OK:
        dir.list_dir_begin()
        var filename = dir.get_next()
        while (filename != ""):
            if filename.ends_with(".png"):
                _words.append(filename.left(filename.length()-4))
            filename = dir.get_next()

func pick_words(no_of_words : int) -> Array:
    return _pick_words(no_of_words, -1)

func pick_other_words(no_of_words : int, excluded_word : String) -> Array:
    return _pick_words(no_of_words, _words.find(excluded_word))
    
func mix_words(words : Array, word : String) -> Array:
    # Deep copy
    var res := Array()
    for w in words:
        res.append(w)
    
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    
    var index = rng.randi_range(0, res.size())
    if index == res.size():
        res.append(word)
    else:
        res.insert(index, word)
        
    return res

func _pick_words(no_of_words : int, excluded_index : int) -> Array:
    var res := Array()
    var wi := Array()
    
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    
    # Randomize indexes
    for i in range(_words.size()):
        if i == excluded_index:
            continue
        if wi.size() == 0:
            wi.append(i)
        else:
            var index = rng.randi_range(0, wi.size())
            if index == wi.size():
                wi.append(i)
            else:
                wi.insert(index, i)
    
    # Pick words using randomized indexes
    for i in range(no_of_words):
        res.append(_words[wi[i]])
    
    return res
    
func format_word(word : String, upper : bool) -> String:
    var w = tr("WORD_" + word)
    
    if upper:
        return w.to_upper()
    else:
        return w.to_upper().left(1) + w.to_lower().right(1)

func path_from_word(word : String) -> String:
    return "res://assets/images/words/" + word.to_lower() + ".png"

func print_words() -> void:
    print(_words)