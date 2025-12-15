@tool
extends PopochiuHotspot
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1


# Interact: When the node is left clicked.
func _on_click() -> void:
    var lines = [
        "I feel as though a cold hand holds me back from going further. This wing is not meant for the living.",
        "When I was little, visiting Granny Grace here, I mis-hacked a hacky sack and sent it flying into the impenetrable dark of this hallway, never to be hacked again.",
        "The South Wing. A portal to another dimension, or simply an unfinished portion of the house? The former, obviously.",
        "Inexplicably, the breath is stolen from my lungs as I approach the South Wing. A fan of breathing, I turn back.",
    ]
    await InteractUtil.approach_and_say(Random.choose_value(lines))


func _on_double_click() -> void:
    _on_click()


# Look: When the node is right clicked.
func _on_right_click() -> void:
    await RoomUtil.look_door(
        "The South Wing. We don't go that way anymore. Not since last Thursday."
    )


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



