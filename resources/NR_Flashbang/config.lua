Config = {
	WeaponLabel = "閃光彈",
	ExplodeTime = 2500,             			-- msec
	
	ExplosionEffectVisibilityRange = 50.0,

	CanCutOutMumble = true,
	MumbleCutOutDuration = 10000, 				-- msec

	WeakEffectDuration = 5000,					-- msec
	FlashEffectDuration = 15000,				-- msec
	WeakEffectSoundDuration = 9500,			-- msec
	FlashEffectWhiteScreenDuration = 2500, 		-- msec
	FlashEffectWhiteScreenFadeOutTempo = 1.0,
	AfterExplosionCameraReturnDuration = 3000, 	-- msec

	WeakEffectSoundVolume = 0.05,
	FlashEffectSoundVolume = 0.08,

	UpdateEffectVolumeOnWeakEffect = true,

	WeakEffectRange = { farthest = 11.0, nearest = 4.0 },
	FlashEffectBehindPlayerRange = 2.0,
	FlashEffectInFrontOfPlayerRange = 4.0,
}