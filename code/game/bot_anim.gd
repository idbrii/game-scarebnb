class_name BotAnim
extends Node2D


func set_facing(flip_h):
    for sprite in get_children():
        sprite.flip_h = flip_h


func idle():
    drive()
    # No idle animation, so just freeze.
    $Body.stop()


func drive():
    $Body.play("robot_yellow_drive_loop")
