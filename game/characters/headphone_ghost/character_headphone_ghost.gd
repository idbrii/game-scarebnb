@tool
extends PopochiuCharacter
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.

const Data := preload('character_headphone_ghost_state.gd')

var state: Data = load("res://game/characters/headphone_ghost/character_headphone_ghost.tres")


var seen_intro := false
var has_ascended := false

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# When the room in which this node is located finishes being added to the tree
func _on_room_set() -> void:
    pass


# Interact: When the node is left clicked.
func _on_click() -> void:
    await C.player.walk_to_clicked()
    await C.player.face_clicked()
    if seen_intro:
        D.EvanMusicFreestyle.start()
    else:
        _intro_convo()
        seen_intro = true
    # Using a long convo instead of a dialog.
    #~ D.EvanHomeNoiseComplaint.start()


# Teleport: Node is double left clicked.
func _on_double_click() -> void:
    # Replace the call to E.command_fallback() with your code.
    E.command_fallback()
    # For example, you could make the player instantly do something instead of walking there first


# Look: When the node is right clicked.
func _on_right_click() -> void:
    await InteractUtil.face_and_say("One of our spectral... er, special guests.")


# When the node is middle clicked
func _on_middle_click() -> void:
    # Replace the call to E.command_fallback() to implement your code.
    E.command_fallback()


# When the node is clicked and there is an inventory item selected
func _on_item_used(item: PopochiuInventoryItem) -> void:
    if try_accept_new_sound(item):
        return

    match item:
        I.Letter:
            await C.player.say("I don't think he has the patience for reading.")


func try_accept_new_sound(item: PopochiuInventoryItem):
    var is_sound := true
    match item:
        I.SoundBloop:
            say("Bloop-a-bloop! Hm. That's blooping on the beat!")
        I.SoundNeigh:
            say("Na na na neigh. That one's a winnie-r.")
        I.SoundBonk:
            say("Ba ba bonk. Bonka bonka.")
        I.SoundZweee:
            say("ZweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeEEEEEEEEEEEeeeeeeeeeee.")
        I.SoundHonk:
            say("It could be the new cow bell.")
        I.SoundDing:
            say("It's almost too small to hear, but dink dink I think that's it!")
        _:
            is_sound = false
    if is_sound:
        item.remove(true)
        D.EvanMusicFreestyle.turn_on_options([item.script_name.to_upper()])

    return is_sound


# Use it to play the idle animation for the character
func _play_idle() -> void:
    super()


# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func _play_walk(target_pos: Vector2) -> void:
    super(target_pos)


# Use it to play the talk animation for the character
func _play_talk() -> void:
    super()


# Use it to play the grab animation for the character
func _play_grab() -> void:
    super()


# Called when the character stops moving
func _on_move_ended() -> void:
    pass




# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Public ░░░░ {{{1
# You can add here functions triggered by the GUI commands. For example, if your GUI has a command
# for look_at, you could have the function:
#func on_look_at() -> void:
    #pass



func _intro_convo():
    E.queue([
        "HeadphoneGhost: [shake] Ohhh heyyy ohhh[/shake] Shamma lamma scriddle dama ding dong! [shake]Honnnh YEAH![/shake]",
        "Player: Er, hello? ",
        "HeadphoneGhost: [shake]Ohhh heyyy ohhh[/shake] Flimma flamma shraddle ringa manga shonen isekai! [shake]Honn–ARGGH! DON’T INTERRUPT THE PROCESS, MAN!![/shake]",
        "Player: Sorry, I’ve just received complaints of someone pummelling a goose with a cold in here. ",
        "HeadphoneGhost: Huh? Naw, man. It’s the sound of searching for my SOUND. And I can’t [i]find[/i] it, my guy…",
        "Player: Your… sound? ",
        "HeadphoneGhost: When I croaked, I was searching for the ONE sound that would complete my song, man. ",
        "HeadphoneGhost: And not just ANY song, man. My SOUL song. ",
        "Player: I see. Your soul sounds like assaulting a sick goose. Bummer. ",
        "HeadphoneGhost: NO, man! That’s the problem! It’s missing a [b]SOUND[/b]. The sound that’ll transform it from a beat-down bird to a soaring swan! ",
        "HeadphoneGhost: If I could find that one [b]SOUND[/b] to complete my soul-song? Man… That’d be pure “Honnnh yeah,” man.",
        "Player: Well, we’ll do our best to make your stay pure “Honnnh yeah.” Man."
    ])

func _idle_talk():
    var lines = [
        "Writing songs is hard, man. It’s like, what even [i]is[/i] songs? ",
        "Songs are like ghosts… Yeah, sounds deep. I should put that in a song…",
        "I write songs to touch people’s souls. I don’t know what a ‘soul’ is, if I’m bein’ honest, man, but I wanna touch it. …I think? That sounds bad.",
        "I don’t know where my songs end and I begin, man. Probably my mouth, though. ",
    ]
    await say(Random.choose_value(lines))
