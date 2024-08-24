extends AnimatedSprite2D

@onready var tanks = [$"tank-0", $"tank-1", $"tank-2", $"tank-3"]
@onready var connects = [$"connect-1", $"connect-2", $"connect-3"]
var last_call = -1

# Called when the node enters the scene tree for the first time.
func _ready():
    #tanks.map(func(t): t.autoplay = true)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var fuel = FuelManager.fuel
    if abs(last_call - fuel) < .05:
        return
    
    var i_fuel = min(3, int(fuel))
    connects.map(func(x): x.visible = false)
    tanks.map(func(x): x.play("0"))
    
    for i in range(i_fuel):
        connects[i].visible = true
        
    for i in range(4):
        var f = fuel - i
        
        var t:AnimatedSprite2D = tanks[i]
        var a = str(int(max(min(5, f * 5), 0)))
        
        if t.animation != a:
            #await get_tree().create_timer(0.1).timeout
            t.play(str(a))
            
    last_call = fuel
        
        #if f >= 1:
            #t.play("5")
        #elif f >= 0.8:
            #t.play("4")
        #elif f >= 0.6:
            #t.play("3")
        #elif f >= 0.4:
            #t.play("2")
        #elif f >= 0.2:
            #t.play("1")
        #else:
            #t.play("0")            
        
        
        
    
    
    ##var current_tank = 
    #
    #tank_1.play(str(int(fuel)))
    #pass
    #

