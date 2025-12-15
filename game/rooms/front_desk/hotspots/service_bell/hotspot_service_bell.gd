@tool
extends PopochiuHotspot
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# Interact: When the node is left clicked.
func _on_click() -> void:
    if I.SoundDing.can_collect():
        await InteractUtil.approach_and_say("dink!")
        InteractUtil.drop_sound_item(I.SoundDing, self)
        await C.player.say("It’s the quietest bell I’ve ever heard, as though rung from somewhere deep, deep under murky emerald water. Just thinking about it sends a chill up my spine.")

    else:
        var generic_lines := [
            "I don't want to hear that distant tinkle again today.",
            "I hit my daily dinks limit.",
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
    await InteractUtil.face_and_say("A bell for guests to ring to get my attention.")


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



