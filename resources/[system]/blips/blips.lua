
	local blips = {
		-- The Prison
		{title="彌敦道水上競速", colour=46, id=316, x=-2108.77, y=2590.61, z=-0.470},
		-- {title="UFC擂台", colour=1, id=491, x=105.82, y=-1940.03, z=22.220},
		{title="北區醫院", colour=2, id=61, x=1827.81, y=3691.28, z=33.224},
		{title="Wargmae場1", colour=50, id=181, x=1783.93, y=3295.26, z=41.79},
		{title="Wargmae場2", colour=50, id=181, x=1561.04, y=3569.82, z=33.13},
		{title="秋明山入口", colour=46, id=127, x=148.74, y=6433.65, z=31.31},
		-- {title="勞工處", colour=27, id=407, x=-265.0, y=-963.6, z=30.2}

		}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


