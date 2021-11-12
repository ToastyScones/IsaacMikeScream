local mikecry = RegisterMod("mikecry",1)
local sound = SFXManager()
local mikehurt = Isaac.GetSoundIdByName("mikehurt")
local mikedie = Isaac.GetSoundIdByName("mikedie")

function mikecry:takeDamage(target,amount,flag,source,num)
	local player = Isaac.GetPlayer(0)
	if target.Type == EntityType.ENTITY_PLAYER then
		sound:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
		sound:Play(mikehurt, 1.0, 0, false, 1.0)
	end

	if EntityType.ENTITY_PLAYER == IsDead() then
		sound:Stop(SoundEffect.SOUND_ISAACDIES)
		sound:Play(mikedie, 1.0, 0, false, 1.0)
	end
end

function mikecry:takeDamage2(target, damage, flags, source, damageCountdown)
	Isaac.DebugString("hello")
	Isaac.DebugString(tostring(mikehurt))
	local player = Isaac.GetPlayer(0)
	if target.Type == EntityType.ENTITY_PLAYER then
		Isaac.DebugString("Player got Dmg")
		sound:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
		sound:Play(mikehurt, 1.0, 0, false, 1.0)
	end

	if player:IsDead() then
		Isaac.DebugString("Player got dead")
		sound:Stop(SoundEffect.SOUND_ISAACDIES)
		sound:Play(mikedie, 1.0, 0, false, 1.0)
	end
end

--mikecry:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EntityType.ENTITY_PLAYER, takeDamage)
--mikecry:AddCallback(ModCallbacks.IsDead(), mikedie)
mikecry:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mikecry.takeDamage2)