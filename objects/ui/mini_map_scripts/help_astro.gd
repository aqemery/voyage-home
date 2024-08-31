extends AnimatedSprite2D

func _ready() -> void:
    SignalManager.collect_astronomer.connect(queue_free)
