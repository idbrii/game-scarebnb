class_name InteractUtil
extends Resource


static func get_room_pretty_name(room: PopochiuRoom):
    match room:
        R.Hall01:
            return "Guest Hall"
        R.Hall02:
            return "Guest Hall"
        R.CircusRoom:
            return "Three Ring Room"
        R.HorseRoom:
            return "Equestrian Room"
        R.FrontDesk:
            return "Front Desk"
        R.NauticalRoom:
            return "Nautical Room"

    return room.script_name


# Talk verb. TODO(dbriscoe): Doesn't work. It just waits forever.
static func approach_and_queue(queue):
    await C.player.walk_to_clicked()
    await C.player.face_clicked()
    await E.queue(queue)


# Look verb on things you need to approach to examine.
static func approach_and_say(text):
    await C.player.walk_to_clicked()
    await face_and_say(text)


# Look verb on things you can see from a distance.
static func face_and_say(text):
    await C.player.face_clicked()
    await C.player.say(text)


static func ghost_ascend_to_afterlife(ghost: PopochiuCharacter):
    ghost.has_ascended = true
    await ghost.say_afterlife()
    await Animators.fade_out(ghost.get_node("Sprite2D"), 1.0)
    ghost.visible = false
