include('shared.lua')

function ENT:Draw()
    self:DrawModel()

    render.SetMaterial(Material("cable/rope"))
    local pos = self:LocalToWorld(self.Rotors[0].Position)
    local ang = self:LocalToWorldAngles(self.Rotors[0].Rotation)
    render.DrawBeam(pos, pos + ang:Forward() * 50, 5, 0, 250, color_black)

    local pos = self:LocalToWorld(self.Rotors[1].Position)
    local ang = self:LocalToWorldAngles(self.Rotors[1].Rotation)
    render.DrawBeam(pos, pos + ang:Forward() * 50, 5, 0, 250, color_black)
end

function ENT:GSBHudDriverInfo(x, y, speed)

end

function ENT:GSBCalcViewFirstPerson(view, ply)
    return view
end