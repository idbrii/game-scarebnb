@tool
extends PopochiuHotspot
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# Interact: When the node is left clicked.
func _on_click() -> void:
    if I.SoundNeigh.can_collect():
        await InteractUtil.approach_and_say("Two horses, painted in a neo-realist style. They seem to recognize the horse in the painting on the other wall, and are unsure whether or not to bother him for a photo.")
        InteractUtil.drop_sound_item(I.SoundNeigh, self)
        await C.player.say("NEIGH, they think. Too embarrassing.")

    else:
        var generic_lines := [
            "Their flared nostrils make you look away and blush.",
            "Stallion is not a word to be thrown around lightly.",
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
    _on_click()


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



