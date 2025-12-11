class_name InteractUtil
extends Resource


static func get_room_pretty_name(room: PopochiuRoom):
    match room.script_name:
        "Hall01":
            return "South Hall"
        "Bedroom01":
            return "Library Room"

    return room.script_name
