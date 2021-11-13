local mikecry = RegisterMod("mikecry",1)
local sfxManager = SFXManager()
local sfxVolume = 1.0
local sfxFrameDelay = 0
local sfxLoop = false
local mikeHurtMaxXmlId = 3 -- mikehurt1 through 3
local mikeDiesSoundIds = {
	[1] = Isaac.GetSoundIdByName("mikedie1"),
	[2] = Isaac.GetSoundIdByName("mikedie2"),
	[3] = Isaac.GetSoundIdByName("mikedie3"),
	[4] = Isaac.GetSoundIdByName("mikedie4")
}

function mikecry:takeDmgCallback(target, damage, flags, source, damageCountdown)
	local player = Isaac.GetPlayer(0)

	if target.Type == EntityType.ENTITY_PLAYER then
		local mikeHurtXmlId = math.random(1,mikeHurtMaxXmlId)
		local mikeHurtSoundId = Isaac.GetSoundIdByName("mikehurt" .. mikeHurtXmlId)

		sfxManager:Play(mikeHurtSoundId, sfxVolume, sfxFrameDelay, sfxLoop, 1-(player.SpriteScale.X-1))
	end
end

function mikecry:hurtCallback()
	if (sfxManager:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT)) then
		sfxManager:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
	end
end

function mikecry:deathCallback()
	local isIsaacDiesPlaying = sfxManager:IsPlaying(SoundEffect.SOUND_ISAACDIES)
	local player = Isaac.GetPlayer(0)

	if (isIsaacDiesPlaying) then
		sfxManager:Stop(SoundEffect.SOUND_ISAACDIES)

		local isMikeDiesPlaying = false
		for _, soundId in ipairs(mikeDiesSoundIds) do
			isMikeDiesPlaying = isMikeDiesPlaying or sfxManager:IsPlaying(soundId) 
		end 

		if (not (isMikeDiesPlaying)) then
			local index = math.random(1, 3)
			sfxManager:Play(mikeDiesSoundIds[index], sfxVolume, sfxFrameDelay, sfxLoop, 1-(player.SpriteScale.X-1))
		end
	end
end

function mikecry:lostSoulCallback(entityFamiliar)
	if (sfxManager:IsPlaying(SoundEffect.SOUND_ISAACDIES)) then
		sfxManager:Stop(SoundEffect.SOUND_ISAACDIES)

		local isMikeDiesPlaying = false
		for _, soundId in ipairs(mikeDiesSoundIds) do
			isMikeDiesPlaying = isMikeDiesPlaying or sfxManager:IsPlaying(soundId) 
		end 

		if (not (isMikeDiesPlaying)) then
			local index = math.random(1, 3)
			sfxManager:Play(mikeDiesSoundIds[index], sfxVolume, sfxFrameDelay, sfxLoop, 2.5)
		end
	end
end

mikecry:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mikecry.takeDmgCallback)
mikecry:AddCallback(ModCallbacks.MC_POST_UPDATE, mikecry.hurtCallback);
mikecry:AddCallback(ModCallbacks.MC_POST_UPDATE, mikecry.deathCallback);
mikecry:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mikecry.lostSoulCallback, FamiliarVariant.LOST_SOUL);