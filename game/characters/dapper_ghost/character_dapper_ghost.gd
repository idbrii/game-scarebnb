@tool
extends PopochiuCharacter
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.

const Data := preload('character_dapper_ghost_state.gd')

var state: Data = load("res://game/characters/dapper_ghost/character_dapper_ghost.tres")


var has_seen_intro := false
var has_ascended := false

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# When the room in which this node is located finishes being added to the tree
func _on_room_set() -> void:
    pass


# Interact: When the node is left clicked.
func _on_click() -> void:
    var jokes = [
            D.DapperJokeCar,
            D.DapperJokeSheet,
            D.DapperJokeJailLetter,
            D.DapperJokeSadSketch,
        ]

    await C.player.walk_to_clicked()
    await C.player.face_clicked()
    if has_seen_intro:
        for dialogue in jokes:
            if not dialogue.has_completed_good_joke:
                dialogue.start()
                return
        InteractUtil.ghost_ascend_to_afterlife(self)

    else:
        D.DapperHomeIntro.start()


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
func _on_item_used(_item: PopochiuInventoryItem) -> void:
    # Replace the call to E.command_fallback() to implement your code.
    E.command_fallback()
    # For example, you can make the player character say something when the Key item is used in this
    # character. Note that you have to change the name of the `_item` parameter to `item`.
    #~ if item == I.Sheet:
    #~     await C.player.say("I don't want to give up my key")


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


func say_afterlife():
    await E.queue([
        "DapperGhost: [shake]Haw haw haw![/shake] ",
        "DapperGhost: Ah, kid!!! The timing! The punchlines! I think I was too hard on ya. You’ve got chops, kid. If this B'n'B thing don’t work out, look me up. ‘Course, you’ll have to die first. [shake]Haw haw haw![/shake] ",
        "DapperGhost: Ahhh. Only a good laugh can lift a weight off your soul like that. I feel ready to step onto the big stage in the sky... ",
        "DapperGhost: Too bad I gotta give you a one-star review for not havin’ a mini-bar.",
        "Player: [shake]!!! What the–?[/shake]",
        "DapperGhost: C’mon, kid! I thought you knew a joke when you heard one! [shake]Haw haw haw![/shake]",
    ])


func say_idle():
    var line = Random.choose_value([
        "Y’got any jokes? Any punchlines? I’m [shake]dyin’[/shake] of boredom over here. ",
        "Y’mind bonkin’ your head with somethin’? I could use a laugh. [shake]But not too hard![/shake] I don’t want you hauntin’ me forever… ",
        "Maybe I shoulda been a lawyer. They go [i]straight[/i] to Heaven. Or was that the other way… ",
    ])
    await say(line)
