## A special AspectRatioContainer that holds a player and adapts to the aspect
## ratio of the contained player.
class_name VideoContainer
extends AspectRatioContainer

@export var autoplay_video: VideoResource

@onready var player: VideoStreamPlayer = get_child(0)


func _ready():
    # Required configuration for player.
    player.autoplay = false
    player.expand = true

    if autoplay_video != null:
        play_video(autoplay_video)


func play_video(video_def):
    self.ratio = video_def.get_aspect()
    player.stream = video_def.video_stream
    player.volume_db = video_def.volume_db
    player.play()
