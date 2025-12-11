@tool
extends PopochiuHotspot
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# Interact: When the node is left clicked.
func _on_click() -> void:
    await C.player.walk_to_clicked()
    await C.player.face_clicked()
    await E.wait(0.5)
    for n in 3:
        await C.player.face_left()
        await E.wait(0.3)
        await C.player.face_right()
        await E.wait(0.3)
    await C.player.face_clicked()
    await C.player.say("I wanted to open the window,")
    await C.player.say("but I can't find the handle.")


func _on_double_click() -> void:
    # Replace the call to E.command_fallback() with your code.
    PopochiuUtils.e.command_fallback()
    # For example, you could make the player instantly goto another room on an exit hotspot instead
    # of waiting for the player to walk there.
#    await R.current = R.NewRoom


# Look: When the node is right clicked.
func _on_right_click() -> void:
    await C.player.face_clicked()
    await C.player.say("The weather is so nice today.")
    await C.player.say("Can I open that window?")


# When the node is middle clicked
func _on_middle_click() -> void:
    # Replace the call to E.command_fallback() to implement your code.
    PopochiuUtils.e.command_fallback()


# Interact: When the node is left clicked. and there is an inventory item selected
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



