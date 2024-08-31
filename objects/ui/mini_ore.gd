extends AnimatedSprite2D

@export var id:int

func _ready() -> void:
    SignalManager.collect_ore.connect(collected)

func collected(ore_id):
    if ore_id == id:
        queue_free()
