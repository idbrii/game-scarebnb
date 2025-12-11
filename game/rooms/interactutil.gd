class_name InteractUtil
extends Resource


static func get_room_pretty_name(room: PopochiuRoom):
    match room.script_name:
        "Hall01":
            return "South Hall"
        "Bedroom01":
            return "Library Room"

    return room.script_name


# Look verb on things you need to approach to examine.
static func approach_and_say(text):
    await C.player.walk_to_clicked()
    await face_and_say(text)


# Look verb on things you can see from a distance.
static func face_and_say(text):
    await C.player.face_clicked()
    await C.player.say(text)


