@tool
extends PopochiuCharacter
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.

const Data := preload('character_granny_ghost_state.gd')

var state: Data = load("res://game/characters/granny_ghost/character_granny_ghost.tres")


var seen_intro := false

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# When the room in which this node is located finishes being added to the tree
func _on_room_set() -> void:
    pass


# Interact: When the node is left clicked.
func _on_click() -> void:
    await C.player.walk_to_clicked()
    await C.player.face_clicked()
    if seen_intro:
        _idle_talk()
    else:
        _intro_convo()
        seen_intro = true


# Teleport: Node is double left clicked.
func _on_double_click() -> void:
    # Replace the call to E.command_fallback() with your code.
    E.command_fallback()
    # For example, you could make the player instantly do something instead of walking there first


# Look: When the node is right clicked.
func _on_right_click() -> void:
    await InteractUtil.face_and_say("Granny ran this ghost B&B for decades. She left this house to me.")
    await C.player.say("She told me that she fondly remembers my childhood visits and that I loved it because I have “The Sight,” just like her.")


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
#    if item == I.Key:
#        await C.player.say("I don't want to give up my key")


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
        "GrannyGhost: Hi dearie. My puzzle isn't done yet, so you'll just have to wait a bit.",
    ])

func _idle_talk():
    var lines = [
        "I’m just so proud of you, Basil. I wish I could pinch your cheeks–to [i]death![/i] Then I’d have them with me in the afterlife! [shake]Hee hee hee![/shake]",
        "I knew I left this B&B to the right person. Mainly because you’re the only person who inherited [shake]The Sight[/shake] from me! ",
        "The guests here need your help, Basil. Look after them carefully, will you, dear?",
        "I love horses. Why, they’re my second favourite animal. I would’ve decorated this room after my first favourite animal, but axolotl decorations cost [shake]TWICE as much![/shake] Can you be-[i]lieve[/i] that?? Tsk. ",
        "By week’s end, if we have a low [b]Guest Score[/b] on [i]Trivaghost,[/i] (Oh I just love that dashing man’s [i]big[/i] teeth! [shake]Homina homina![/shake]), the [b]Inspector[/b] will shut us down! Then our guests will go [shake]straight to Purgatory–no chance of redemption, no shot at a nice afterlife! A-and that includes m-me![/shake] ",
    ]
    await say(Random.choose_value(lines))
