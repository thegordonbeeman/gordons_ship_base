ENT.GordonsShipBase = true

ENT.Type        = "anim"
ENT.PrintName   = "Base Ship"
ENT.Author      = "Gordon Beeman"
ENT.Information = "Base script for Gordon's Ship Base"
ENT.Category    = "Why would you put this in a category"

ENT.Spanwable       = false
ENT.AdminSpawnable  = false

ENT.AutomaticFrameAdvance   = true
ENT.RenderGroup             = RENDERGROUP_BOTH

ENT.Model = ""

ENT.Mass = 3000 -- Custom weight in kilograms, used in calculations, use -1 to use the model's weight as attributed in the QC

ENT.Buoyancy = 0.2

ENT.Rotors = {} --{ContinuousHP = X in Horsepower, MaxHP = Y in Horsepower, Position = Vector, Rotation = Angle}

ENT.Seats = {
    [0] = {Pos = Vector(0, 0, 0), Ang = Angle(0, 0, 0), Weapons = {}}
} --complex

function ENT:SetupDataTables()
    self:NetworkVar( "Entity",0, "Driver" )
    self:NetworkVar( "Entity",1, "DriverSeat" )
	
	self:NetworkVar( "Bool",0, "Active" )
	self:NetworkVar( "Bool",1, "EngineActive" )
	self:NetworkVar( "Bool",2, "IsGroundTouching" )

	self:NetworkVar( "Float",0, "RPM" )
	self:NetworkVar( "Float",1, "Heading" )
	self:NetworkVar( "Float",2, "HP" )

	self:CustomDataTables(2, 3, 3)
end

function ENT:CustomDataTables(Entities, Bools, Floats)
    -- add NetworkVars here using {Entities/Bools/Floats} + n as an id
end