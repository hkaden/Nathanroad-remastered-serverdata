Config = {

	--BLIPS FOR JOB CENTERS
	BlipCenterSprite = 498,
	BlipCenterColor = 3,
	BlipCenterText = '職業中心',

	MarkerSprite = 27,
	MarkerColor = {66, 135, 245},
	MarkerSize = 1.1,

	LocationsJobCenters = { -- If you want you can setup locations to change jobs (Leave without entiries if you dont want locations) (ADDS 0.02 MS)
		{coords = vector3(-265.33, -963.02, 31.22), blip = true}
	},

	--Boss menu locations
	BossMenuLocations = {
		{coords = vector3(460.2197, -985.4608, 30.7281), job = "police", label = "警察"},
		{coords = vector3(305.29, -599.8698, 43.28407), job = "ambulance", label = "醫院"},
		{coords = vector3(-696.9, -791.02, 31.53), job = "mechanic", label = "修車工"},
		{coords = vector3(-162.54, -1173.82, 23.77), job = "cardealer", label = "車行"},
		{coords = vector3(-1178.13, -895.16, 13.97), job = "burgershot", label = "餐廳"},
		{coords = vector3(-600.67, -720.29, 116.81), job = "realestateagent", label = "地產"},
		{coords = vector3(-1376.64, -621.88, 35.9), job = "mafia1", label = "白玫瑰"},
		{coords = vector3(-223.59, -372.58, 58.8), job = "mafia2", label = "和聯勝"},
		{coords = vector3(94.05, -1293.06, 29.26), job = "mafia3", label = "赤花會"},
		{coords = vector3(-816.1, -698.05, 32.14), job = "reporter", label = "電視台"},
		-- {coords = vector3(115.6415, -131.2773, 60.48844), job = "cardealer", label = "車行"}
	},

	--Boss menu users by grade name and their permissions
	BossMenuUsers = {
		['boss'] = {canWithdraw = false, canDeposit = false, canHire = true, canRank = true, canFire = true, canBonus = true},
		['recruit'] = {canWithdraw = false, canDeposit = false, canHire = false, canRank = false, canFire = false, canBonus = false}
	},

	DefaultJobsInJobCenter = { -- Jobs that can be added by going to the job center. For icons use https://fontawesome.com/
		{job = 'miner', label = "礦工", icon = "fas fa-gem", description = "他們負責提供修車廠的原材料、等等合成的原材料"},
		{job = 'fisherman', label = "漁夫", icon = "fas fa-fish", description = "他們負責向餐廳提供魚類的原材料"},
		{job = 'chickenman', label = "雞佬", icon = "fas fa-egg", description = "他們負責向餐廳提供雞肉的原材料"},
		-- {job = 'slaughterer', label = "屠夫", icon = "fas fa-paw", description = "他們負責向餐廳提供牛肉的原材料"},
		{job = 'tailor', label = "裁縫", icon = "fas fa-tshirt", description = "製造及出售衣服"}
	},

	Text = {
		['open_jobcenter_ui_hologram'] = '[~b~E~w~] 訪問職業中心',
		['promoted'] = '你已被升職了',
		['promoted_other'] = '你於其他職業被升職了!',
		['fired'] = '你已被解僱',
		['fired_other'] = '你已被解僱',
		['hired'] = '你已被僱用',
		['bossmenu_hologram'] = '[~b~E~w~] 打開老闆選單',
		['action_success'] = '操作成功',
		['action_unsuccessful'] = '操作不成功',
		['cant_access_bossmenu'] = '你不能打開老闆選單',
		['insufficent_balance'] = '餘額不足',
		['bonus_given'] = '花紅已發!',
		['bonus_recieved'] = '你已收到花紅! +$'
	}
}

-- Only change if you know what are you doing!
function SendTextMessage(msg)
	ESX.UI.Notify('info', msg)
	-- SetNotificationTextEntry('STRING')
	-- AddTextComponentString(msg)
	-- DrawNotification(0,1)

	--EXAMPLE USED IN VIDEO
	--exports['mythic_notify']:SendAlert('error', msg)
end
