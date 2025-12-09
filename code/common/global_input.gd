extends Node
## Add to any scenes where these global inputs are valid (gameplay scenes,
## but not loading scenes).

var CHEATS_ENABLED := true


func _input(event: InputEvent):
    if Input.is_action_just_pressed("toggle_fullscreen"):
        get_viewport().set_input_as_handled()
        _swap_fullscreen_mode()

    elif Input.is_action_just_pressed("quit_game"):
        get_viewport().set_input_as_handled()
        get_tree().quit()

    elif CHEATS_ENABLED:
        if _cheat_input(event):
            get_viewport().set_input_as_handled()


func _cheat_input(_event: InputEvent) -> bool:
    if Input.is_action_just_pressed("cheat_slomo"):
        if Engine.time_scale < 1:
            Engine.time_scale = 1
        else:
            Engine.time_scale = 0.1
        return true

    elif Input.is_action_just_pressed("cheat_teleport"):
        var player = get_tree().get_nodes_in_group(Groups.PLAYER)[0]
        if player:
            player.global_position = player.get_global_mouse_position()
            return true

    return false


func _swap_fullscreen_mode():
    if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
    else:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
