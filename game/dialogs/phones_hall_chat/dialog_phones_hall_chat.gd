@tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func _on_start() -> void:
    # something to execute before showing the dialog options.
    # (!) It MUST always use an await
    await E.queue([
        C.player.queue_say("Hi! Whatcha listening to?"),
        C.HeadphoneGhost.queue_say("My favourite album."),
        ])
    await PopochiuUtils.e.get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
    # You can make the player character say the selected option with:
    await D.say_selected()

    # Use match to check which option was selected and execute something for
    # each one
    match opt.id:
        "WhoAlbum":
            C.HeadphoneGhost.say("My favourite artist.")
        "ListenRoom":
            C.HeadphoneGhost.say("Are my headphones leaking sound again? I didn't think I was making too much noise.")
        _:
            # By default close the dialog. Options won't show after calling
            # stop()
            stop()

    _show_options()


# Use this to save custom data for this PopochiuDialog when saving the game.
# The Dictionary must contain only JSON supported types: bool, int, float, String.
func _on_save() -> Dictionary:
    return {}


# Called when the game is loaded.
# This Dictionary should has the same structure you defined for the returned one in _on_save().
func _on_load(data: Dictionary) -> void:
    prints(data)



