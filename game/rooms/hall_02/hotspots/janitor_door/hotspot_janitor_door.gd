@tool
extends PopochiuHotspot
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# Interact: When the node is left clicked.
func _on_click() -> void:
    if I.Sheet.can_collect():
        await InteractUtil.approach_and_say("I shove the door open an inch, pushing against a mountain of junk inside.")
        # TODO: drop Fonk
        await C.player.say("FONK. An object of note tumbles out just as I manage to slam the door shut again.")
        I.Sheet.add()

    else:
        var generic_lines := [
            "The door jostles against a mountain of junk, unable to open more than an inch. The junk trembles menacingly, and you shut the door before it has a chance to burst out.",
            "You go to open the Broom Closet, but a deep, haunting voice floats from beyond the door: “Occupied.”",
        ]
        await InteractUtil.approach_and_say(Random.choose_value(generic_lines))


# Teleport: Node is double left clicked.
func _on_double_click() -> void:
    # Replace the call to E.command_fallback() with your code.
    PopochiuUtils.e.command_fallback()
    # For example, you could make the player instantly goto another room on an exit hotspot instead
    # of waiting for the player to walk there.
#    await RoomUtil.teleport_door(R.NewRoom)


# Look: When the node is right clicked.
func _on_right_click() -> void:
    await InteractUtil.face_and_say("Where we keep the cleaning supplies...")
    await InteractUtil.face_and_say("And maybe the cleaners too?")


# Unused.
func _on_middle_click() -> void:
    # Replace the call to E.command_fallback() to implement your code.
    PopochiuUtils.e.command_fallback()


# When the node is clicked and there is an inventory item selected
func _on_item_used(_item: PopochiuInventoryItem) -> void:
    # Replace the call to E.command_fallback() to implement your code.
    PopochiuUtils.e.command_fallback()
    # For example, you can make the player character say something when the Key item is used in this
    # hotspot. Note that you have to change the name of the `_item` parameter to `item`.
#    if item == I.Key:
#        await C.player.say("No can do")




# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Public ░░░░ {{{1
# You can add here functions triggered by the GUI commands. For example, if your GUI has a command
# for look_at, you could have the function:
#func on_look_at() -> void:
    #pass



