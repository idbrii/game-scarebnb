class_name RoomUtil
extends Resource


# Look verb on doors.
static func look_door(text):
    await C.player.face_clicked()
    await C.player.say(text)


# Use verb on doors.
static func use_door(destination):
    await C.player.walk_to_clicked()
    await teleport_door(destination)


# Teleport verb on doors.
static func teleport_door(destination):
    R.set_current(destination)
