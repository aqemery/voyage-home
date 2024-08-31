extends AnimatedSprite2D

func _ready() -> void:
    SignalManager.collect_engineer.connect(queue_free)
