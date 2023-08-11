AddFlashBangExplosion = function(coords)
    AddExplosion(coords.x, coords.y, coords.z, 24, 0.0, true, false, true)
	AddExplosion(coords.x, coords.y, coords.z, 2, 0.0, true, false, true)
end

SetCurrentPedWeapon_ = function(ped, weaponHash)
    SetCurrentPedWeapon(ped, weaponHash, true)
end