@tool
extends PopochiuDialog

var has_completed_good_joke := false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func _on_start() -> void:
    # something to execute before showing the dialog options.
    # (!) It MUST always use an await
    InteractUtil.setup_dapper_joke(self, I.License)
    await E.queue([
        "DapperGhost: Hey, you’re back. You wanna try a joke with me? Alright, here we go…",
        "DapperGhost: Say, do you know how I died?",
        ])
    await PopochiuUtils.e.get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
    # You can make the player character say the selected option with:
    #~ await D.say_selected()

    # Use match to check which option was selected and execute something for
    # each one
    match opt.id:
        "BAD":
            await E.queue([
                "Player: Oh, heavens no. I’d never ask that.",
                "DapperGhost: I… Well, I know how this JOKE died.",

                "DapperGhost: Go [shake]find some INSPIRATION[/shake] around here, kid!",
            ])
            stop()

        "GOOD":
            await E.queue([
                "Player: Oh, a terrible car accident.",
                "DapperGhost: Really? But I’m a perfect driver!",
                "Player: So perfect you thought you didn’t need your [shake]SHEET BELT![/shake]",

                "DapperGhost: Ooh, that was a chippy zinger, kid! Keep it up! Come back when you’ve got more [shake]INSPIRATION![/shake]",
            ])
            has_completed_good_joke = true
            stop()

        _:
            await C.player.say("I just remembered I left the tap running.")
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



