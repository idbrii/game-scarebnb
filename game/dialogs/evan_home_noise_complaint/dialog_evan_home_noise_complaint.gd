@tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func _on_start() -> void:
    await C.player.face_clicked()
    # (!) It MUST always use an await
    E.queue([
        "HeadphoneGhost: [shake] Ohhh heyyy ohhh[/shake] Shamma lamma scriddle dama ding dong! [shake]Honnnh YEAH![/shake]",
        "Player: Er, hello?",
        "HeadphoneGhost: [shake]Ohhh heyyy ohhh[/shake] Flimma flamma shraddle ringa manga shonen isekai! [shake]Honn–ARGGH! DON’T INTERRUPT THE PROCESS, MAN!![/shake]",
        "Player: Sorry, I’ve just received complaints of someone pummelling a goose with a cold in here. ",
        ])
    await PopochiuUtils.e.get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
    # You can make the player character say the selected option with:
#    await D.say_selected()

    # Use match to check which option was selected and execute something for
    # each one
    match opt.id:
        "NOISE_COMPLAINT":
            await D.say_selected()
            E.queue([
                "HeadphoneGhost: Huh? Naw, man. It’s the sound of searching for my SOUND. And I can’t [i]find[/i] it, my guy…",
                "Player: Your… sound? ",
                "HeadphoneGhost: When I croaked, I was searching for the ONE sound that would complete my song, man. ",
                "HeadphoneGhost: And not just ANY song, man. My SOUL song. ",
                "Player: I see. Your soul sounds like assaulting a sick goose. Bummer. ",
                "HeadphoneGhost: NO, man! That’s the problem! It’s missing a [b]SOUND[/b]. The sound that’ll transform it from a beat-down bird to a soaring swan! ",
                "HeadphoneGhost: If I could find that one [b]SOUND[/b] to complete my soul-song? Man… That’d be pure “Honnnh yeah,” man.",
                "Player: Well, we’ll do our best to make your stay pure “Honnnh yeah.” Man."
            ])
            stop()

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
