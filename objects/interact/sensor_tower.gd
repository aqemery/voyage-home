extends AnimatedSprite2D

var active = false

func _on_area_2d_body_entered(body):
     if not active:
        Inventory.towers += 1
        play("powerup")
        active = true

func _on_animation_finished():
    play("powered")
