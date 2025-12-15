@tool
extends PopochiuProp
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the execution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

# Interact: When the node is left clicked.
func _on_click() -> void:
    if I.SoundBonk.can_collect():
        await InteractUtil.approach_and_say("I touch the mattress, expecting the familiar flex and bounce of a waterbed, but I BONK my fingers against something hard.")
        InteractUtil.drop_sound_item(I.SoundBonk, self)
        await C.player.say("Another touch confirms it—it’s a sand mattress. A small crab scuttles under the sheets before reburying itself in the mattress.")

    else:
        var generic_lines := [
            "How many crabs are in there?",
            "I'll have to ask our cleaning staff about this. Or the landscaper?",
        ]
        await InteractUtil.approach_and_say(Random.choose_value(generic_lines))




# Teleport: Node is double left clicked.
func _on_double_click() -> void:
    # Replace the call to E.command_fallback() with your code.
    PopochiuUtils.e.command_fallback()
    # For example, you could make the player instantly do something instead of walking there first


# Look: When the node is right clicked.
func _on_right_click() -> void:
    await InteractUtil.face_and_say("A luxury bed.\nIt has the softest springs and plushest duvet a shoestring budget can buy.")


# When the node is middle clicked
func _on_middle_click() -> void:
    # Replace the call to E.command_fallback() to implement your code.
    PopochiuUtils.e.command_fallback()


# When the node is clicked and there is an inventory item selected
func _on_item_used(_item: PopochiuInventoryItem) -> void:
    # Replace the call to E.command_fallback() to implement your code.
    PopochiuUtils.e.command_fallback()
    # For example, you can make the player character say something when the Key item is used in this
    # prop. Note that you have to change the name of the `_item` parameter to `item`.
#    if item == I.Key:
#        await C.player.say("I can't do that")


# When an inventory item linked to this Prop (link_to_item) is removed from
# the inventory (i.e. when it is used in something that makes use of the object).
func _on_linked_item_removed() -> void:
    pass


# When an inventory item linked to this Prop (link_to_item) is discarded from
# the inventory (i.e. when the player throws the object out of the inventory).
func _on_linked_item_discarded() -> void:
    pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Public ░░░░ {{{1

# You can add here functions triggered by the GUI commands. For example, if your GUI has a command
# for look_at, you could have the function:
#func on_look_at() -> void:
    #pass


