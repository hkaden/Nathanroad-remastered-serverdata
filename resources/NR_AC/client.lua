
local function GetWeaponName(weapon)
  local currweaponname = weapon
  for i, v in pairs(weaponTypes) do
    if GetHashKey(v) == weapon then
      currweaponname = v
      break
    end
  end
  return currweaponname
end


local function MathRound(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

Citizen.CreateThread(function()
	while true do
    local sleep = 1000
    local ped = PlayerPedId()
		local playerPos = GetEntityCoords(ped)
    local selectedWeapon = GetSelectedPedWeapon(ped)
		if selectedWeapon ~= -1569615261 then
      sleep = 3000
      local fireRate = MathRound(GetWeaponTimeBetweenShots(selectedWeapon), 3)
      local damageModifier = MathRound(GetWeaponDamageModifier(selectedWeapon), 3)
      local weaponDamage = MathRound(GetWeaponDamage(selectedWeapon), 3)
      local clipSize = GetWeaponClipSize(selectedWeapon)
      local maxAmmoInClip = GetMaxAmmoInClip(ped, selectedWeapon)
      local WeaponName = GetWeaponName(selectedWeapon)
      local weaData = weaponData[WeaponName]
      if weaData then
        if fireRate > weaData.fireRate then
          print('39', fireRate, weaData.fireRate, fireRate < weaData.fireRate, 'fireRate')
          TriggerServerEvent('NR_AC:CheatDetected', 'fireRate', weaData.fireRate, string.format("%.3f",fireRate), WeaponName)
        end
        if damageModifier > weaData.damageModifier then
          print('40', damageModifier, weaData.damageModifier, damageModifier > weaData.damageModifier, 'damageModifier')
          TriggerServerEvent('NR_AC:CheatDetected', 'damageModifier', weaData.damageModifier, string.format("%.3f",damageModifier), WeaponName)
        end
        if weaponDamage > weaData.weaponDamage then
          print('41', weaponDamage, weaData.weaponDamage, weaponDamage > weaData.weaponDamage, 'weaponDamage')
          TriggerServerEvent('NR_AC:CheatDetected', 'weaponDamage', weaData.weaponDamage, string.format("%.3f",weaponDamage), WeaponName)
        end
        if clipSize > weaData.clipSize then
          print('42', clipSize, weaData.clipSize, clipSize > weaData.clipSize, 'clipSize')
          TriggerServerEvent('NR_AC:CheatDetected', 'clipSize', weaData.clipSize, string.format("%.3f",clipSize), WeaponName)
        end
        if maxAmmoInClip > weaData.maxAmmoInClip then
          print('43', maxAmmoInClip, weaData.maxAmmoInClip, maxAmmoInClip > weaData.maxAmmoInClip, 'maxAmmoInClip')
          TriggerServerEvent('NR_AC:CheatDetected', 'maxAmmoInClip', weaData.maxAmmoInClip, string.format("%.3f",maxAmmoInClip), WeaponName)
        end
      end

      if printWeaponData then
        print('39', fireRate, weaData.fireRate, fireRate > weaData.fireRate, 'fireRate')
        print('40', damageModifier, weaData.damageModifier, damageModifier > weaData.damageModifier, 'damageModifier')
        print('41', weaponDamage, weaData.weaponDamage, weaponDamage > weaData.weaponDamage, 'weaponDamage')
        print('42', clipSize, weaData.clipSize, clipSize > weaData.clipSize, 'clipSize')
        print('43', maxAmmoInClip, weaData.maxAmmoInClip, maxAmmoInClip > weaData.maxAmmoInClip, 'maxAmmoInClip')

        print("Fire Rate : ".. string.format("%.3f",fireRate) .. " (" .. WeaponName .. ")")
        print("Damage Modifier : " .. string.format("%.3f",damageModifier) .. " (" .. WeaponName .. ")")
        print("Weapon Damage : " .. string.format("%.3f",weaponDamage) .. " (" .. WeaponName .. ")")
        print("Clip Size : " .. clipSize .. " (" .. WeaponName .. ")")
        print("Max Ammo In Clip : " .. maxAmmoInClip .. " (" .. WeaponName .. ")")
        print("Weapon Name : " .. WeaponName)
        print("Weapon Hash : " .. selectedWeapon)
        print("Weapon Data : ", weaData)
      end

    else
      sleep = 1000
		end
    Citizen.Wait(sleep)
  end
end)
