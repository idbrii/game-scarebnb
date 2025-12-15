@tool
extends PopochiuHotspot
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.

var can_collect_license := false
var can_collect_letter := false

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# Interact: When the node is left clicked.
func _on_click() -> void:
    if can_collect_license:
        await InteractUtil.approach_and_say("Someone left their license behind these flowers!")
        I.License.add()
        can_collect_license = false

    elif can_collect_license:
        await InteractUtil.approach_and_say("There was a letter left behind the license behind the flowers!!")
        I.Letter.add()
        can_collect_letter = false

    else:
        await InteractUtil.approach_and_say("They smell like a summer meadow... Or maybe just a meadow air freshener.")


# Teleport: Node is double left clicked.
func _on_double_click() -> void:
    # Replace the call to E.command_fallback() with your code.
    PopochiuUtils.e.command_fallback()


# Look: When the node is right clicked.
func _on_right_click() -> void:
    await (
        InteractUtil
        . face_and_say(
            "We try to keep something to entertain guests when they're waiting for their local haunts to open."
        )
    )


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



