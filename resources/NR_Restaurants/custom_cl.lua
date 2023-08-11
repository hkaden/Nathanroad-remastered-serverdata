local Items = {
	['candy'] = {
		name    = 'Candy',
		itemName    = 'candy',
		type    = 'herb',           -- links to drug presets.
		quality = 1.0,              -- quality of drug/effect strength modifier   float           (0.1 - 2.0)
		instant = false,            -- is effect instant?                         true or false
		sober   = false,            -- does this effect cancel all other effects? true or false
		effects = {
			move_speed    = false,      -- set player movement speed?  false or float  (0.0 - 2.0)
			add_armor     = false,      -- add armor to player?        false or int    (0-100)
			add_health    = false,    -- add health to player?       false or int    (0-100)
			take_armor    = false,    -- take armor from player?     false or int    (0-100)
			take_health   = false,    -- take health from player?    false or int    (0-100)
			health_regen  = false,      -- set health regen multi?     false or float  (0.0 - 2.0)
		},
		animation = {
			type      = "animation",
			dict      = 'amb@world_human_smoking_pot@male@base',
			anim      = 'base',
			blend_in  = 8.0,
			blend_out = -8.0,
			flag      = 48,
			start     = 0.0,
			prop      = 'p_cs_joint_01',
			bone      = 18905,
			wait      = true,
		},
	},
}

RegisterNetEvent('NR_Restaurants:client:CandyCandy', function()
	local randomNum = math.random(1, 100)
	if randomNum > 0 and randomNum <= 35 then -- 35%
		-- Effect 1 持續飽腹度+渴度
		TriggerEvent('esx_status:add', 'slowhunger', 670)
		TriggerEvent('esx_status:add', 'slowthirst', 670)
		ESX.UI.Notify('success', '覺得好飽肚', false, 10000)
	elseif randomNum > 35 and randomNum <= 55 then -- 20%
		-- Effect 2 醉酒暈畫面+暈倒
		TriggerEvent('esx_status:add', 'drunk', 120)
		TriggerEvent('esx_status:add', 'stun', 60)
		ESX.UI.Notify('success', '覺得醉了', false, 10000)
	elseif randomNum > 55 and randomNum <= 70 then -- 15%
		-- Effect 3 中毒效果
		Items['candy'].quality = 0.3
		Items['candy'].effects.move_speed = 0.8
		exports['mf-drugfx']:DrugsApply(Items['candy'])
		TriggerEvent('esx_status:add', 'slowdamage', 50)
		ESX.UI.Notify('success', '覺得好不詳', false, 10000)
	elseif randomNum > 70 and randomNum <= 82 then -- 12%
		-- Effect 4 加跑速
		TriggerEvent('esx_status:add', 'speedrun', 180)
		ESX.UI.Notify('success', '覺得識飛', false, 10000)
	elseif randomNum > 82 and randomNum <= 92 then -- 10%
		-- Effect 5 啪毒畫面
		ESX.UI.Notify('success', '覺得好唔舒服', false, 10000)
		Items['candy'].quality = 1.3
		Items['candy'].effects.move_speed = 0.6
		exports['mf-drugfx']:DrugsApply(Items['candy'])
	elseif randomNum > 92 and randomNum <= 97 then -- 5%
		-- Effect 6 熱能畫面+強力止痛藥
		-- (strength, duration, NVDuration)
		TriggerEvent('medicine:Candy', 0.5, 120, 60)
		ESX.UI.Notify('success', '狼人上身', false, 10000)
	elseif randomNum > 97 and randomNum <= 100 then -- 3%
		-- Effect 7 黑白畫面+死亡
		SetEntityHealth(PlayerPedId(), 0)
		ESX.UI.Notify('success', '真係好閪黑', false, 10000)
	end
end)