extends AnimatedSprite2D

func _ready() -> void:
    SignalManager.collect_exobiologist.connect(queue_free)
