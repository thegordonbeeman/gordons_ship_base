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
        Position = Vector(-302, -39, 20), Rotation = Angle(5, 180, 0),
        Order = 1, MaxTurn = 30
    },
    [1] = {
        ContinuousHP = 700, MaxHP = 850,
        Position = Vector(-302, 39, 20), Rotation = Angle(5, 180, 0),
        Order = -1, MaxTurn = 30
    }
}

ENT.Seats = {
    [0] = {Pos = Vector(185, -10, 100), Ang = Angle(0, 0, 0), Weapons = {}}
}