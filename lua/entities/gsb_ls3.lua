AddCSLuaFile()

ENT.Type = "anim"
DEFINE_BASECLASS('base_ship')

ENT.PrintName   = "LS-3"
ENT.Information = "German light torpedo boat"
ENT.Author      = "Gordon Beeman"
ENT.Category    = "GSB"

ENT.Spawnable = true

ENT.Model = "models/gordon/germany/ships/ls3.mdl"

ENT.Mass = 12000
ENT.Buoyancy = 0.1

ENT.Rotors = {
    [0] = {
        ContinuousHP = 700, MaxHP = 850,
        Position = Vector(-39, -302, 20), Rotation = Angle(180, 0, 5),
        Order = 1, MaxTurn = 30
    },
    [1] = {
        ContinuousHP = 700, MaxHP = 850,
        Position = Vector(39, -302, 20), Rotation = Angle(180, 0, 5),
        Order = -1, MaxTurn = 30
    }
}

ENT.Seats = {
    [0] = {Pos = Vector(20, 170, 95), Ang = Angle(0, 0, 0), Weapons = {}}
}