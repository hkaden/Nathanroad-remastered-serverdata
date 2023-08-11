ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cul:rectanglecoord', function(_source, points, result)
	local ped = GetPlayerPed(_source)
	local pedcoords = GetEntityCoords(ped)
	local p = vector2(pedcoords.x, pedcoords.y)
	local a = points.a
	local b = points.b
	local c = points.c
	local d = points.d

	local s = 0
	
	local ab = #(a-b)
	local bc = #(b-c)
	local ac = #(a-c)
	local bd = #(b-d)
	local ad = #(a-d)
	local cd = #(c-d)
	
	s = (ab+bc+ac) / 2
	local abc = math.sqrt(s*(s-ab)*(s-bc)*(s-ac))

	s = (ab+bd+ad) / 2
	local abd = math.sqrt(s*(s-ab)*(s-bd)*(s-ad))

	local rec = abc + abd
	
	local ap = #(a-p)
	local bp = #(b-p)
	local cp = #(c-p)
	local dp = #(d-p)

	s = (ap+bp+ab) / 2
	local abp = math.sqrt(s*(s-ap)*(s-bp)*(s-ab))

	s = (bp+cp+bc) / 2
	local bcp = math.sqrt(s*(s-bp)*(s-cp)*(s-bc))
	
	s = (cp+dp+cd) / 2
	local cdp = math.sqrt(s*(s-cp)*(s-dp)*(s-cd))
	
	s = (ap+dp+ad) / 2
	local adp = math.sqrt(s*(s-ap)*(s-dp)*(s-ad))

	local recs = abp+adp+bcp+cdp
	result(math.floor(recs*10)/10 == math.floor(rec*10)/10)
end)