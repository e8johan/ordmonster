extends Control

enum { MENU, SETTINGS, GAME, RESULT }

var _current_view : int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # This is on purpose. The word collection is only guaranteed to make sense in Swedish.
    TranslationServer.set_locale("sv")
    
    _show_view(MENU)

func _notification(what: int) -> void:
    if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST or what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
        match _current_view:
            MENU:
                _on_Menu_quit_clicked()
            SETTINGS:
                _show_view(MENU)
            GAME:
                # You cannot go back from a game, but you can close the window
                if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
                    get_tree().quit()
            RESULT:
                _show_view(MENU)

func _show_view(v) -> void:
    # We want to prevent switching from one screen to the same screen as the transitions may trigger actions
    if v == _current_view:
        return
        
    $Menu.visible = false
    $Settings.visible = false
    $Results.visible = false
    $Game.visible = false
    
    _current_view = v
    
    match v:
        MENU:
            $Menu.visible = true
        SETTINGS:
            $Settings.visible = true
        GAME:
            $Game.initialize_game()
            $Game.start_game()
            $Game.visible = true
        RESULT:
            $Results.visible = true

func _on_Menu_play_clicked() -> void:
    _show_view(GAME)

func _on_Menu_settings_clicked() -> void:
    _show_view(SETTINGS)

func _on_Menu_quit_clicked() -> void:
    get_tree().quit()

func _on_Settings_back_clicked() -> void:
    _show_view(MENU)

func _on_Results_back_clicked() -> void:
    _show_view(MENU)

func _on_Game_game_over(time, words, mistakes) -> void:
    $Results.time_seconds = time
    $Results.words = words
    $Results.mistakes = mistakes
    $Results.update_view()
    _show_view(RESULT)
