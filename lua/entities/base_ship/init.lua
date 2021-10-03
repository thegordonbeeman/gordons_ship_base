AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua')

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    else
        print("Gordon's Ship Base: MODEL INVALID")
        return
    end

    if (self.Mass != -1) then
        phys:SetMass(self.Mass)
    end

    self:InitPod()
    self:OnSpawn()
end

function ENT:OnSpawn()

end

function ENT:InitPod()
	if IsValid( self:GetDriverSeat() ) then return end
	
	local Pod = ents.Create( "prop_vehicle_prisoner_pod" )
	
	if not IsValid( Pod ) then
		self:Remove()
		
		print("[Gordon's Ship Base]: POD IS FUCKED")
		
		return
	else
		self:SetDriverSeat( Pod )
		
		local podPhys = Pod:GetPhysicsObject()
		
		Pod:SetMoveType( MOVETYPE_NONE )
		Pod:SetModel( "models/nova/airboat_seat.mdl" )
		Pod:SetKeyValue( "vehiclescript","scripts/vehicles/prisoner_pod.txt" )
		Pod:SetKeyValue( "limitview", 0 )
		Pod:SetPos( self:LocalToWorld( self.Seats[0].Pos ) )
		Pod:SetAngles( self:LocalToWorldAngles( self.Seats[0].Ang ) )
		Pod:SetOwner( self )
		Pod:Spawn()
		Pod:Activate()
		Pod:SetParent( self )
		Pod:SetNotSolid( true )
		--Pod:SetNoDraw( true )
		Pod:SetColor( Color( 255, 255, 255, 0 ) ) 
		Pod:SetRenderMode( RENDERMODE_TRANSALPHA )
		Pod:DrawShadow( false )
		Pod.DoNotDuplicate = true
		Pod:SetNWInt( "pPodIndex", 1 )
		
		if IsValid( podPhys ) then
			podPhys:EnableDrag( false ) 
			podPhys:EnableMotion( false )
			podPhys:SetMass( 1 )
		end
		self:DeleteOnRemove( Pod )
	end
end

function ENT:HandleEngine()
	-- local IdleRPM = self:GetIdleRPM()
	-- local MaxRPM = self:GetMaxRPM()
	-- local LimitRPM = self:GetLimitRPM()
	-- local MaxVelocity = self:GetMaxVelocity()
	
	-- local EngActive = self:GetEngineActive()

	-- local KeyThrottle = false
	-- local KeyBrake = false

	-- self.TargetRPM = self.TargetRPM or 0
	
	-- if EngActive then
	-- 	local Pod = self:GetDriverSeat()
		
	-- 	if not IsValid( Pod ) then return end
		
	-- 	local Driver = Pod:GetDriver()
		
	-- 	local RPMAdd = 0
		
	-- 	if IsValid( Driver ) then 
	-- 		KeyThrottle = Driver:lfsGetInput( "+THROTTLE" )
	-- 		KeyBrake = Driver:lfsGetInput( "-THROTTLE" )
			
	-- 		RPMAdd = ((KeyThrottle and self:GetThrottleIncrement() or 0) - (KeyBrake and self:GetThrottleIncrement() or 0)) * FrameTime()
	-- 	end
		
	-- 	if KeyThrottle ~= self.oldKeyThrottle then
	-- 		self.oldKeyThrottle = KeyThrottle
			
	-- 		self:OnKeyThrottle( KeyThrottle )
	-- 	end
		
	-- 	self.TargetRPM = math.Clamp( self.TargetRPM + RPMAdd,IdleRPM,((self:GetAI() or KeyThrottle) and self:GetWepEnabled()) and LimitRPM or MaxRPM)
	-- else
	-- 	self.TargetRPM = self.TargetRPM - math.Clamp(self.TargetRPM,-250,250)
	-- end

	-- if isnumber( self.VtolAllowInputBelowThrottle ) and not self:GetAI() then
	-- 	local MaxRPMVtolMin = self:GetMaxRPM() * ((self.VtolAllowInputBelowThrottle - 1) / 100)

	-- 	if self:GetRPM() < MaxRPMVtolMin and not KeyThrottle then
	-- 		self.TargetRPM = math.min( self.TargetRPM, MaxRPMVtolMin )
	-- 	end

	-- 	--[[ -- while it makes perfect sense to clamp it in both directions, it just doesnt feel right
	-- 	local MaxRPMVtolMax = self:GetMaxRPM() * (self.VtolAllowInputBelowThrottle / 100)
	-- 	if self:GetRPM() > MaxRPMVtolMax and not KeyBrake then
	-- 		self.TargetRPM = math.max( self.TargetRPM, MaxRPMVtolMax )
	-- 	end
	-- 	]]--
	-- end

	-- self:SetRPM( self:GetRPM() + (self.TargetRPM - self:GetRPM()) * FrameTime() )
	
	-- local PhysObj = self:GetPhysicsObject()
	
	-- if not IsValid( PhysObj ) then return end
	
	-- local fThrust = MaxVelocity * (self:GetRPM() / LimitRPM) - self:GetForwardVelocity()
	
	-- if not self:IsSpaceShip() and not self:GetAI() then fThrust = math.max( fThrust ,0 ) end
	
	-- local Force = fThrust / MaxVelocity * self:GetMaxThrust() * LimitRPM * FrameTime()
	
	-- if self:IsDestroyed() or not EngActive then
	-- 	self:StopEngine()
		
	-- 	return
	-- end
    return {[0] = 100, [1] = 100}
end

function ENT:HandleStart()
	local Driver = self:GetDriver()
	
	if IsValid( Driver ) then
		local KeyReload = Driver:lfsGetInput( "ENGINE" ) -- retiens fdp
		
		if self.OldKeyReload ~= KeyReload then
			self.OldKeyReload = KeyReload
			if KeyReload then
				self:ToggleEngine()
			end
		end
	end
end

function ENT:HandleRotors(phys, rotors)
    local DriverSeat = self:GetDriverSeat()
    if not IsValid(DriverSeat) then return end
    local Driver = DriverSeat:GetDriver()
    if (IsValid(Driver)) then
        rudderInput = 0 --playerInput
        for k, rotor in pairs(self.Rotors) do
            PrintTable(rotor)
        end
    end
end

function ENT:Use(ply)
    if ply:IsPlayer() then
        local DriverSeat = self:GetDriverSeat()

        if (IsValid(DriverSeat) and not IsValid(DriverSeat:GetDriver()) and not ply:KeyDown(IN_WALK)) then
            ply:EnterVehicle(DriverSeat)
        else
			local Seat = NULL
			local Dist = 500000
			
			-- for _, v in pairs( self:GetPassengerSeats() ) do
			-- 	if IsValid( v ) and not IsValid( v:GetDriver() ) then
			-- 		local cDist = (v:GetPos() - ply:GetPos()):Length()
					
			-- 		if cDist < Dist then
			-- 			Seat = v
			-- 			Dist = cDist
			-- 		end
			-- 	end
			-- end
			
			if IsValid( Seat ) then
				ply:EnterVehicle( Seat )
			else
				if not IsValid( self:GetDriver() ) and not AI then
					ply:EnterVehicle( DriverSeat )
				end
			end
		end
    end
end

function ENT:Think()
    local phys = self:GetPhysicsObject()

    phys:SetBuoyancyRatio(self.Buoyancy)
    local RotorsForces = self:HandleEngine(phys)
    self:HandleRotors(phys, RotorsForces)

    self:NextThink(CurTime())
	return true
end

function ENT:StopEngine()

end

function ENT:OnEngineStarted()
end

function ENT:OnEngineStopped()
end