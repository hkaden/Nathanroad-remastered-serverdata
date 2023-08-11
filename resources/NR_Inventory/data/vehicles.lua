return {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0] = {4, 1000},		-- Compact
		[1] = {4, 1000},		-- Sedan
		[2] = {4, 1000},		-- SUV
		[3] = {4, 1000},		-- Coupe
		[4] = {4, 1000},		-- Muscle
		[5] = {4, 1000},		-- Sports Classic
		[6] = {4, 1000},		-- Sports
		[7] = {4, 1000},		-- Super
		[8] = {4, 1000},		-- Motorcycle
		[9] = {4, 1000},		-- Offroad
		[10] = {4, 1000},		-- Industrial
		[11] = {4, 1000},		-- Utility
		[12] = {4, 1000},		-- Van
		[14] = {4, 1000},	-- Boat
		[15] = {4, 1000},	-- Helicopter
		[16] = {4, 1000},	-- Plane
		[17] = {4, 1000},		-- Service
		[18] = {4, 1000},		-- Emergency
		[19] = {4, 1000},		-- Military
		[20] = {4, 1000},		-- Commercial (trucks)
		models = {
			-- Game money
			[`tmodel`] = {10, 5000},
			[`dbx`] = {10, 5000},

			-- Sponsor
			[`sf90spider`] = {10, 14000},
			[`pts21`] = {10, 14000},
			[`mbbs20`] = {10, 14000},
			-- [`xa21`] = {5, 220000},
			-- [`t20`] = {5, 220000},
		},
		plates = {
			-- ['ET'] = {6, 240000}
		}
	},

	trunk = {
		[0] = {10, 4000},		-- Compact
		[1] = {10, 4000},		-- Sedan
		[2] = {10, 4000},		-- SUV
		[3] = {10, 4000},		-- Coupe
		[4] = {10, 4000},		-- Muscle
		[5] = {10, 4000},		-- Sports Classic
		[6] = {10, 4000},		-- Sports
		[7] = {10, 4000},		-- Super
		[8] = {10, 4000},		-- Motorcycle
		[9] = {10, 4000},		-- Offroad
		[10] = {10, 4000},	-- Industrial
		[11] = {10, 4000},	-- Utility
		[12] = {10, 4000},	-- Van
		-- [14] -- Boat
		-- [15] -- Helicopter
		-- [16] -- Plane
		[17] = {10, 4000},	-- Service
		[18] = {10, 4000},	-- Emergency
		[19] = {10, 4000},	-- Military
		[20] = {10, 4000},	-- Commercial
		models = {
			-- [`xa21`] = {10, 13000},
			-- [`t20`] = {10, 13000},
			[`benson`] = {10, 20000},
			-- EMS
			[`ambu`] = {10, 20000},
			[`dodgeEMS`] = {10, 15000},
			[`ACTPOLavant`] = {10, 15000},
			[`wmfenyrcop`] = {10, 50000},
			[`polamggtr`] = {10, 50000},
			[`polchiron`] = {10, 50000},
			[`bmw5pol`] = {10, 50000},
			[`hwp2018v2`] = {10, 50000},
			[`polgt2rs`] = {10, 50000},
			[`bmwpoliceb`] = {10, 5000},
			[`policebenz`] = {10, 100000},
			[`rmodfordpolice`] = {10, 50000},
			[`polbmwm4`] = {10, 50000},
			[`suppressor`] = {10, 50000},
			[`nspeedo`] = {10, 50000},

			-- Game money
			[`wildtrak`] = {10, 8000},

			-- Sponsor
			[`senna`] = {10, 13000},
			[`bc`] = {10, 13000},
			[`rmodsianr`] = {10, 13000},
			[`rmodbolide`] = {10, 13000},
			[`488snl`] = {10, 13000},
			[`918`] = {10, 13000},
			[`topcar911`] = {10, 13000},
			[`rmodveneno`] = {10, 13000},
			[`sabre21`] = {10, 13000},
			[`rmodp1gtr`] = {10, 13000},
			[`SlsBlackSeries`] = {10, 11000},
			[`waldalphard`] = {10, 11000},
			[`giuliagta`] = {10, 11000},

			[`laferrari`] = {10, 13000},
			[`svj63`] = {10, 13000},
			[`rmodgt63`] = {10, 13000},
			[`600lt`] = {10, 13000},
			[`f8t`] = {10, 13000},
			[`teslapd`] = {10, 13000},
			[`2018s63`] = {10, 13000},
			[`720spider`] = {10, 13000},

			[`19dbs`] = {10, 13000},
			-- [`sf90spider`] = {10, 13000},
			[`agerarsc`] = {10, 13000},
			[`amgone`] = {10, 13000},
			[`panamera17turbo`] = {10, 13000},
			[`19raptor`] = {10, 8000},

			[`lexuslm`] = {10, 13000},
			[`g632019`] = {10, 15000},
			[`rmodjesko`] = {10, 13000},
			[`zondar`] = {10, 13000},
			[`lp770`] = {10, 13000},

			[`apolloie`] = {10, 13000},
			[`rmodbacalar`] = {10, 13000},
			[`rmodbugatti`] = {10, 13000},
			[`812nlargo`] = {10, 13000},
			[`avs`] = {10, 13000},
			[`terzo`] = {10, 13000},
			[`mcp1`] = {10, 13000},
			[`amggtr`] = {10, 13000},
			[`taycan21`] = {10, 13000},
			[`wmfenyr`] = {10, 13000},

			[`pistas`] = {10, 13000},
			[`urus19`] = {10, 13000},
			[`765`] = {10, 13000},
			[`brabus500`] = {10, 13000},
			[`imola`] = {10, 13000},
			[`2019gt3rs`] = {10, 13000},
			[`20r1`] = {10, 13000},
			[`rmoddarki82`] = {10, 13000},
			[`rmoddarki8`] = {10, 13000},

			[`rmodgtr50`] = {10, 13000},
			[`rmodf12tdf`] = {10, 13000},
			[`gt2rs`] = {10, 13000},

			[`tesroad20`] = {10, 13000},
		},
		plates = {
			['NRHK5270'] = {10, 18000}
		},
		boneIndex = {
			[`pounder`] = 'wheel_rr'
		}
	}
}
