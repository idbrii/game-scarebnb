@tool
extends PopochiuDialog


var num_success := 0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func get_sound_items():
    return [
        I.SoundBloop,
        I.SoundBonk,
        I.SoundDing,
        I.SoundHonk,
        I.SoundNeigh,
        I.SoundZweee,
    ]


func _build_options():
    return [
        create_option("SOUNDBLOOP")
            .with_text("BLOOP")
            .with_visible(false)
            ,
        create_option("SOUNDNEIGH")
            .with_text("NEIGH")
            .with_visible(false)
            ,
        create_option("SOUNDBONK")
            .with_text("BONK")
            .with_visible(false)
            ,
        create_option("SOUNDZWEEE")
            .with_text("ZWEEE")
            .with_visible(false)
            ,
        create_option("SOUNDHONK")
            .with_text("HONK")
            .with_visible(false)
            ,
        create_option("SOUNDDING")
            .with_text("dink")
            .with_visible(false)
            ,
        create_option("SOUNDRING")
            .with_text("RING")
            .with_visible(false)
            ,
        create_option("BAD_HUMM")
            .with_text("Hummm?")
            ,
        create_option("BAD_TOOT")
            .with_text("Toot?")
            ,
    ]


func _on_start() -> void:
    var collected_opts = []
    for item in get_sound_items():
        # TODO: require giving them to evan instead of just collecting them?
        if item.has_collected:
            collected_opts.append(item.script_name.to_upper())
    turn_on_options(collected_opts)

    await C.player.face_clicked()
    await E.queue([
        "HeadphoneGhost: Oh, you got some [b]SOUNDS[/b], little guy? Alright. I’m listenin’... ",
    ])
    await PopochiuUtils.e.get_tree().process_frame


func _music_fail():
    await E.queue([
        "HeadphoneGhost: Huh?? That ain’t right…",
        "HeadphoneGhost: [shake]Ohhh heyyy ohhhh[/shake] that-is-a-not-a-the-right-sound you to-tal BU-FOON! Honnnh NO!",
        "HeadphoneGhost: Uh. NO. ",
        "HeadphoneGhost: UGH. My dead ears just died [i]again.[/i]",
    ])


func _music_success():
    await E.queue([
        "HeadphoneGhost:  [shake] Ohhh heyyy ohhh[/shake] Squamma fibby lamma hissy shamma [insert correct sound here] [shake]Honnnh YEAH!!!!!!!!!!!!!!!!!![/shake]",
        "HeadphoneGhost: … Whoa. That was… ",
        "Player: Honnh yeah?",
        "HeadphoneGhost: I couldn’t have said it better myself, man. My soul feels complete, like a perfect song, ringing out of Marshall stacks fifty feet high!",
        "Player: That sounds much better than a punched-up fowl. ",
        "HeadphoneGhost: I’ll be sure to say that on my comment card, my guy. See you in the VIP, alright? Honnnhh YEAHHHHHH!!!",
    ])
    await InteractUtil.ghost_ascend_to_afterlife(C.HeadphoneGhost)


func _option_selected(opt: PopochiuDialogOption) -> void:
    # say the selected option
    await D.say_selected()

    match opt.id:
        "SOUNDBLOOP":
            num_success += 1
            opt.turn_off_forever()
            await E.queue([
                "HeadphoneGhost:  [shake] Ohhh[/shake] Squamma bloop lamma hissy shamma bloop [shake]Honnnh YEAH!!!!!!!!!!!!!!!!!![/shake]",
            ])

        "SOUNDNEIGH":
            num_success += 1
            opt.turn_off_forever()
            await E.queue([
                "HeadphoneGhost:  [shake] Heyyy[/shake] Fibby neigh-o shamma neigh [shake]Honnnh YEAH!!!!!!!!!!!!!!!!!![/shake]",
            ])

        "SOUNDBONK":
            num_success += 1
            opt.turn_off_forever()
            await E.queue([
                "HeadphoneGhost:  [shake] Ohhh bonk[/shake] Shamma bonk bonk [shake]Honnnh YEAH!!!!!!!!!!!!!!!!!![/shake]",
            ])

        "SOUNDZWEEE":
            num_success += 1
            opt.turn_off_forever()
            await E.queue([
                "HeadphoneGhost:  [shake] Ohhh zweeee ohhh[/shake] Squamma fibby lamma hissy shamma [shake]Honnnh YEAH!!!!!!!!!!!!!!!!!![/shake]",
            ])

        "SOUNDHONK":
            num_success += 1
            opt.turn_off_forever()
            await E.queue([
                "HeadphoneGhost:  [shake] Ohhh heyyy ohhh[/shake] Honk honk honk honk honk honk [shake]Honnnh YEAH!!!!!!!!!!!!!!!!!![/shake]",
            ])

        "SOUNDDING":
            num_success += 1
            opt.turn_off_forever()
            await E.queue([
                "HeadphoneGhost:  [shake] OHHH HEYYY OHHH[/shake] SQUAMMA dink LAMMA dink SHAMMA dink [shake]HONNNH YEAH!!!!!!!!!!!!!!!!!![/shake]",
            ])

        "SOUNDRING":
            num_success += 1
            opt.turn_off_forever()
            await E.queue([
                "HeadphoneGhost:  [shake] Ohhh[/shake] Squamma ring a ring a ring [shake]Honnnh YEAH!!!!!!!!!!!!!!!!!![/shake]",
            ])

        "BAD_HUMM":
            _music_fail()
            stop()

        "BAD_TOOT":
            _music_fail()
            stop()

        _:
            # By default close the dialog. Options won't show after calling
            # stop()
            stop()

    if num_success >= get_sound_items().size():
        await _music_success()
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



