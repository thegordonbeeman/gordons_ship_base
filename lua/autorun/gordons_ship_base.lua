local player = FindMetaTable("Player")

function player:GetGSBAxis()
    return (player:KeyDown(IN_FORWARD) and 1 or 0) + (player:KeyDown(IN_BACK) and -1 or 0)
end

function player:getGBSShip()
	if not self:InVehicle() then return NULL end
	local Pod = self:GetVehicle()
	
	if not IsValid( Pod ) then return NULL end
	
	if Pod.GordonsShipBase then
		
		return Pod.GBSShip --later
		
	else
		local Parent = Pod:GetParent()
		
		if not IsValid( Parent ) then return NULL end
		
		if not Parent.GordonsShipBase then return NULL end
		
		Pod.GordonsShipBase = true
		Pod.GBSShip = Parent
		
		return Parent
	end
end

if CLIENT then
    hook.Add("CalcView", "GSB_CalcShipView", function(ply, pos, ang, fov)
        if ply:GetViewEntity() ~= ply then return end
		
		local Pod = ply:GetVehicle()
        local Ship = ply:getGBSShip()

        if not IsValid( Pod ) or not IsValid( Ship ) then return end

        local view = {}
		view.origin = pos
		view.fov = fov
		view.drawviewer = true

        if Ship:GetDriverSeat() ~= Pod then
			view.angles = ply:EyeAngles()
		end
		
		if not Pod:GetThirdPersonMode() then
			
			view.drawviewer = false
			
			return Ship:GSBCalcViewFirstPerson( view, ply )
		end
		
		local radius = 550
		radius = radius + radius * Pod:GetCameraDistance()
		
		local TargetOrigin = view.origin - view.angles:Forward() * radius  + view.angles:Up() * radius * 0.2
		local WallOffset = 4

		local tr = util.TraceHull( {
			start = view.origin,
			endpos = TargetOrigin,
			filter = function( e )
				local c = e:GetClass()
				local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.GordonsShipBase
				
				return collide
			end,
			mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
			maxs = Vector( WallOffset, WallOffset, WallOffset ),
		} )
		
		view.origin = tr.HitPos
		
		if tr.Hit and not tr.StartSolid then
			view.origin = view.origin + tr.HitNormal * WallOffset
		end

		return Ship:LFSCalcViewThirdPerson( view, ply )
    end)
end