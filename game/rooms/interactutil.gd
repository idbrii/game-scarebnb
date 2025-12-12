class_name InteractUtil
extends Resource


static func get_room_pretty_name(room: PopochiuRoom):
    match room:
        R.Hall01:
            return "South Hall"
        R.Bedroom01:
            return "Equestrian Room"
        R.FrontDesk:
            return "Front Desk"

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


