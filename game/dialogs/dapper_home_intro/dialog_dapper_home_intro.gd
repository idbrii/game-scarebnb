@tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func _on_start() -> void:
    # something to execute before showing the dialog options.
    # (!) It MUST always use an await
    await E.queue([
        "DapperGhost: ‘Ey there kid, where’s a recently dead vaudeville comedian to get a drink around here?",
        ])
    await PopochiuUtils.e.get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
    # You can make the player character say the selected option with:
    #~ await D.say_selected()

    var followup = [
        "DapperGhost:(whispered) [i](C’mon kid… I’m settin’ you up for GOLD here.)[/i]",
        "Player: Gold? Like a tip?",
        "DapperGhost: [shake]What? No![/shake] I mean COMEDY gold! You’re supposed to say somethin’ like “I know we’ve got a lotta thirsty ghosts but we don’t serve BOOS here!”",
        "Player: …",
        "DapperGhost: And here I thought [i]I[/i] was lifeless. Y’know, ever since my comedy partner went solo into the afterlife, I can’t help but feel… outta step. If I could do a zippy routine again, with a partner who had [b]PUNCHLINES[/b]–maybe [i]then[/i] I could find some peace…",
        "Player: Oh! BOOS as in BOOZE! Yeah we don’t have that here.",
        "DapperGhost: … I’m gonna spend eternity here, aren’t I?",
    ]

    # Use match to check which option was selected and execute something for
    # each one
    match opt.id:
        "DRINK":
            await E.queue([
                "Player: I don’t know.",
                "DapperGhost: Err, well, uh, does this room have a mini bar, perchance?",
                "Player: … no.",
            ])
            await E.queue(followup)
            C.DapperGhost.has_seen_intro = true
            stop()

        "BAR":
            await D.say_selected()
            await E.queue([
                "DapperGhost: So this room has a mini bar, perchance?",
                "Player: … no.",
            ])
            await E.queue(followup)
            C.DapperGhost.has_seen_intro = true
            stop()

        "COMEDY":
            # This is a shortcut to skip the intro and go straight into the jokes.
            C.player.say("You were a comedian?")
            stop()
            D.DapperJokeCar.start()
            return

        _:
            await C.player.say("Have a wonderful time!")
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



