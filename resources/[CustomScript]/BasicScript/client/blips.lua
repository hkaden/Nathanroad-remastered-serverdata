local blips = {
	{title = "就業中心", colour=7, id = 280, scale = 0.8, coords = vector3(-264.91, -963.67, 31.22)},
	{title = "行政大樓", colour=5, id = 590, scale = 0.8, coords = vector3(-540.32, -212.34, 37.65)},
	-- The Prison
	-- {title="彌敦道水上競速", colour=46, id=316, coords = vector3(-2108.77, 2590.61, -0.470)},
	-- {title="UFC擂台", colour=1, id=491, coords = vector3(105.82, -1940.03, 22.220)},
	-- {title = "北區醫院", colour = 2, id = 61, coords = vector3(1827.81, 3691.28, 33.224)},
	-- {title="Wargmae場1", colour=50, id=181, coords = vector3(1783.93, 3295.26, 41.79)},
	-- {title = "Wargame場", colour = 50, id = 181, coords = vector3(1561.04, 3569.82, 33.13)},
	-- {title = "秋明山賽道", colour = 5, id = 523, coords = vector3(-972.09, -3020.74, 13.95)},
	-- {title = "日本筑波賽道", colour = 5, id = 523, coords = vector3(-972.09, -3020.74, 13.95)},
	-- {title = "澳門東望洋賽道", colour = 5, id = 523, coords = vector3(-966.97, -3011.38, 13.95)},
	-- {title = "比利時斯帕賽道", colour = 5, id = 523, coords = vector3(-961.49, -3000.93, 13.95)},
	-- {title = "Wargame場 No.1", colour = 5, id = 150, coords = vector3(-976.9, -2992.11, 13.95)},
	{title = "機場", colour = 5, id = 307, scale = 0.8, coords = vector3(-976.9, -2992.11, 13.95)},
	{title = "波樓", colour = 34, id = 205, scale = 0.8, coords = vector3(-1606.71, -982.23, 13.02)},
	-- Gang 脫衣舞
	-- {title = "彼岸花", colour = 48, id = 442, coords = vector3(133.51, -1306.45, 29.12)},
	-- {title = "尚賢", colour = 6, id = 84, coords = vector3(11.8, 544.55, 175.85)},
	{title = "白玫瑰", colour = 40, id = 437, scale = 1.0, coords = vector3(-1390.08, -584.64, 30.22)},
	{title = "和聯勝", colour = 17, id = 484, scale = 1.0, coords = vector3(-190.0, -355.26, 58.8)},
	{title = "赤花會", colour = 8, id = 442, scale = 1.0, coords = vector3(133.51, -1306.45, 29.12)},
	-- {title = "豬欄辦事處", colour = 34, id = 205, coords = vector3(-261.55, -736.56, 33.55)},
	-- {title="原材料出售處", colour=2, id=256, coords = vector3(1724.11, 4808.59, 41.68)},
	-- {title="原材料出售處", colour=2, id=256, coords = vector3(-82.58, -1402.06, 29.32)},
	-- {title="巨人Busking", colour=2, id=354, coords = vector3(55.11, -796.79, 31.58)},
	-- {title="勞工處", colour=27, id=407, coords = vector3(-265.0, -963.6, 30.2)},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.coords)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, info.scale)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
    end
end)