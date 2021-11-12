local mikecry = RegisterMod("mikecry",1)
local sfxManager = SFXManager()
local mikehurt = Isaac.GetSoundIdByName("mikehurt")
local mikedie = Isaac.GetSoundIdByName("mikedie")

function mikecry:takeDmgCallback(target, damage, flags, source, damageCountdown)
	local player = Isaac.GetPlayer(0)
	if target.Type == EntityType.ENTITY_PLAYER then
		sfxManager:Play(mikehurt, 1.0, 0, false, 1.0)
	end
end

function mikecry:hurtCallback()
	local isIsaacHurtPlaying = sfxManager:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
	if (isIsaacHurtPlaying) then
		sfxManager:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
	end
end

function mikecry:deathCallback()
	local isIsaacDiesPlaying = sfxManager:IsPlaying(SoundEffect.SOUND_ISAACDIES)
	local isMikeDiesPlaying = sfxManager:IsPlaying(mikedie)
	Isaac.DebugString(tostring(mikedie))
	if (isIsaacDiesPlaying) then
		sfxManager:Stop(SoundEffect.SOUND_ISAACDIES)
		if (not (isMikeDiesPlaying)) then 
			sfxManager:Play(mikedie, 1.0, 0, false, 1.0)
		end
	end
end

mikecry:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mikecry.takeDmgCallback)
mikecry:AddCallback(ModCallbacks.MC_POST_UPDATE, mikecry.hurtCallback);
mikecry:AddCallback(ModCallbacks.MC_POST_UPDATE, mikecry.deathCallback);