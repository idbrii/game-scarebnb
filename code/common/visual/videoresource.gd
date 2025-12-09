class_name VideoResource
extends Resource

@export var video_stream: VideoStream
@export var width: int
@export var height: int
@export var volume_db: float = 0.0  # same default as VideoStreamPlayer

func get_aspect():
    return float(width) / float(height)
