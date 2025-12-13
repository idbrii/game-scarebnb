@tool
class_name ScareJokeDialog
extends PopochiuDialog

var has_completed_good_joke := false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func get_good_item():
    return I.License


func play_joke_setup():
    # Should be just one line.
    await E.queue([
        "DapperGhost: Set up the joke in one line.",
    ])


func play_bad_joke():
    await E.queue([
        "Player: Bad response.",
        "DapperGhost: I… Well, I know how this JOKE died.",
    ])


func play_good_joke():
    await E.queue([
        "Player: Setup for punchline.",
        "DapperGhost: Punchline.",
    ])


func play_quit_excuse():
    await C.player.say("I just remembered I left the tap running.")


func _on_start() -> void:
    # something to execute before showing the dialog options.
    # (!) It MUST always use an await
    InteractUtil.setup_dapper_joke(self, get_good_item())
    await E.queue([
        "DapperGhost: Hey, you’re back. You wanna try a joke with me? Alright, here we go…",
        ])
    play_joke_setup()
    await PopochiuUtils.e.get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
    # You can make the player character say the selected option with:
    #~ await D.say_selected()

    # Use match to check which option was selected and execute something for
    # each one
    match opt.id:
        "BAD":
            await play_bad_joke()
            await E.queue([
                "DapperGhost: Go [shake]find some INSPIRATION[/shake] around here, kid!",
            ])
            stop()

        "GOOD":
            await play_good_joke()
            await E.queue([
                "DapperGhost: Ooh, that was a chippy zinger, kid! Keep it up! Come back when you’ve got more [shake]INSPIRATION![/shake]",
            ])
            has_completed_good_joke = true
            stop()

        _:
            await play_quit_excuse()
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



