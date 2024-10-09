extends Node
class_name fuel_manager

var fuel = 2
var fuel_can_warn = true

func _ready():
    SignalManager.refuel.connect(refuel)

func _physics_process(delta):
    if fuel_can_warn and fuel < 1:
        DialogManager.show_dialog("Your fuel is low!")
        SignalManager.low_fuel.emit()
        fuel_can_warn = false
    if fuel <= 0:
        Inventory.died_cause = Inventory.Cause.FUEL
        SignalManager.respawn.emit()
        fuel = 0.1
         
    
func refuel():
    fuel = 4
    await DialogManager.show_dialog("Fuel refilled!")
    fuel_can_warn = true
