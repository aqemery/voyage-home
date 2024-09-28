extends Node

enum VipState { MISSING, FOUND, RETURNED, UPGRADED }

var astronomer: VipState = VipState.MISSING
var engineer: VipState  = VipState.MISSING
var exobiologist: VipState  = VipState.MISSING
var ore = 0
var relics = 0
var towers = 0
var fog_image: Image
var respawn_pos:Vector2 = Vector2(4075, 13078)
var just_died = false

func reset():
    astronomer = VipState.MISSING
    engineer = VipState.MISSING
    exobiologist = VipState.MISSING
    ore = 0
    relics = 0
    towers = 0
    fog_image = null
    respawn_pos = Vector2(4075, 13078)
    just_died = false
