return {
	-- ['testburger'] = {
	-- 	label = 'Test Burger',
	-- 	weight = 220,
	-- 	degrade = 60,
	-- 	client = {
	-- 		status = { hunger = 200000 },
	-- 		anim = 'eating',
	-- 		prop = 'burger',
	-- 		usetime = 2500,
	-- 		export = 'ox_inventory_examples.testburger'
	-- 	},
	-- 	server = {
	-- 		export = 'ox_inventory_examples.testburger',
	-- 		test = 'what an amazingly delicious burger, amirite?'
	-- 	},
	-- 	buttons = {
	-- 		{
	-- 			label = 'Lick it',
	-- 			action = function(slot)
	-- 				print('You licked the burger')
	-- 			end
	-- 		},
	-- 		{
	-- 			label = 'Squeeze it',
	-- 			action = function(slot)
	-- 				print('You squeezed the burger :(')
	-- 			end
	-- 		}
	-- 	}
	-- },

	['bandage'] = {
		label = '繃帶',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			-- usetime = 2500,
		}
	},

	['black_money'] = {
		label = '黑錢',
		weight = 0
	},


	['parachute'] = {
		label = '降落傘',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			-- usetime = 1500
		}
	},

	['garbage'] = {
		label = '垃圾袋',
		weight = 10,
	},

	['paperbag'] = {
		label = '紙袋',
		weight = 10,
		stack = true,
		close = false,
		consume = 0
	},

	['panties'] = {
		label = '短褲',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			-- usetime = 2500,
		}
	},

	['lockpick'] = {
		label = '解鎖器',
		weight = 200,
		consume = 0,
		client = {
			anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' },
			disable = { move = true, car = true, combat = true },
			-- usetime = 5000,
			cancel = true
		}
	},

	['phone'] = {
		label = '手機',
		weight = 200,
		stack = false,
		consume = 0,
		client = {
			-- usetime = 100,
		}
	},
	['hammerwirecutter'] = {
		label = '錘子及電線鉗',
		weight = 500,
		stack = false,
	},
	['accesscard'] = {
		label = '太平洋標準銀行鑰匙卡',
		weight = 50,
		stack = false,
	},
	['goldbar'] = {
		label = '金條',
		weight = 1000,
		stack = true,
	},
	['goldwatch'] = {
		label = '金錶',
		weight = 800,
		stack = true,
	},
	['money'] = {
		label = '現金',
		weight = 0
	},


	['11mcar_ticket'] = {
		label = '11月精選車輛兌換卷',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['advancedscrewdriver'] = {
		label = '優良螺絲刀',
		weight = 150,
		stack = true,
		close = true,
		description = ''
	},
	['alive_chicken'] = {
		label = '活潑的活雞',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['alive_chicken_injure'] = {
		label = '受傷的活雞',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['alloy'] = {
		label = '合金',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['aluminum'] = {
		label = '鋁(Al)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['aluminumoxide'] = {
		label = '氧化鋁(Al2O3)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['amongblack'] = {
		label = 'Among (Black)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongblue'] = {
		label = 'Among (Blue)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongbrown'] = {
		label = 'Among (Brown)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amonggreen'] = {
		label = 'Among (Green)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongorange'] = {
		label = 'Among (Orange)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongpink'] = {
		label = 'Among (Pink)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongpurple'] = {
		label = 'Among (Purple)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongred'] = {
		label = 'Among (Red)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongwhite'] = {
		label = 'Among (White)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['amongyellow'] = {
		label = 'Among (Yellow)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['antenna'] = {
		label = '天線',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['assaultrifle_pack'] = {
		label = '包裝突擊步槍',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['auto_body'] = {
		label = '自動槍體',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['bagofdope'] = {
		label = '包裝大麻',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['bandage_rare'] = {
		label = '高級繃帶',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['bandage_rare_recipe'] = {
		label = '高級繃帶配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['bandage_recipe'] = {
		label = '繃帶配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['baseballbat_pack'] = {
		label = '包裝球棒',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['battery'] = {
		label = '電池',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['drill_bit'] = {
		label = '鑽頭',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['drill_grip'] = {
		label = '電鑽握把',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['drill_trigger'] = {
		label = '電鑽開關',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['drill_chuck'] = {
		label = '鑽頭夾頭',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['blowpipe'] = {
		label = '噴燈',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['blue_phone'] = {
		label = '智能手機(藍色)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['boating_licenes'] = {
		label = '駕駛船的執照',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['bobbypin'] = {
		label = '萬字夾',
		weight = 20,
		stack = true,
		close = true,
		description = ''
	},
	['bulletproof'] = {
		label = '軟質防彈背心',
		weight = 800,
		stack = true,
		close = true,
		description = ''
	},
	['cameratools'] = {
		label = 'CCTV操作工具',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['campfire'] = {
		label = 'Campfire',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['camtablet'] = {
		label = 'CCTV平板電腦',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['carbinerifle_pack'] = {
		label = '包裝卡賓步槍',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['carokit'] = {
		label = '車體維修包',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['carokit_recipe'] = {
		label = '車體維修包配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['carotool'] = {
		label = '車體維修工具',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['cchip'] = {
		label = '籌碼',
		weight = 5,
		stack = true,
		close = true,
		description = ''
	},
	['ceramics'] = {
		label = '陶瓷',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['chemicals'] = {
		label = '化學藥劑',
		weight = 250,
		stack = true,
		close = true,
		description = ''
	},
	['chip_new'] = {
		label = '籌碼(薪浦驚)',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['chips'] = {
		label = '子彈盒',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['cigarett'] = {
		label = '香煙',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['circuit_board'] = {
		label = '電路板',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['clay'] = {
		label = '黏土',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['clip'] = {
		label = '子彈箱',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['clothe'] = {
		label = '衣服',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['cocaine'] = {
		label = 'Cocaine',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['cocaine_cut'] = {
		label = 'Cut Cocaine',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['cocaine_packaged'] = {
		label = 'Packaged Cocaine',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['cocaine_uncut'] = {
		label = 'Uncut Cocaine',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['coil'] = {
		label = '線圈',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['copper'] = {
		label = '銅',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['copper_coil'] = {
		label = '銅線圈',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['copper_wire'] = {
		label = '銅線',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['craftingbook'] = {
		label = 'Book of crafting',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['craftingtable'] = {
		label = 'Crafting Table',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['crew_add'] = {
		label = '',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['crowbar_pack'] = {
		label = '包裝鐵撬',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['crushedstone'] = {
		label = '碎石',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['crystal_meth'] = {
		label = '高等冰毒',
		weight = 150,
		stack = true,
		close = true,
		description = ''
	},
	['cuff_keys'] = {
		label = '手銬鎖匙',
		weight = 50,
		stack = false,
		close = true,
		consume = 0,
		description = '',
		client = {
			disable = { move = true, car = true, combat = true },
		}
	},
	['cuffs'] = {
		label = '手銬',
		weight = 250,
		stack = true,
		close = true,
		consume = 0,
		description = '',
		client = {
			disable = { move = false, car = true, combat = true },
		}
	},
	['rope'] = {
		label = '繩',
		weight = 100,
		stack = true,
		close = true,
		consume = 0,
		description = '',
		-- client = {
		-- 	disable = { move = false, car = true, combat = true },
		-- }
	},
	['cut_money'] = {
		label = 'Counterfeit Cash - Cut',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['cutted_wood'] = {
		label = '切木',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['defibrillator'] = {
		label = '生命復甦器',
		weight = 750,
		stack = true,
		close = true,
		description = ''
	},
	['defibrillator_recipe'] = {
		label = '生命復甦器配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['ammonia'] = {
		label = '氨(NH3)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['bag'] = {
		label = '袋',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['weed1g'] = {
		label = '大麻 (300G)',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['meth1g'] = {
		label = '冰毒 (300G)',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['coke1g'] = {
		label = '可卡因 (300G)',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['coca'] = {
		label = '古柯葉',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['cocab'] = {
		label = '碎古柯葉',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['coke'] = {
		label = '古柯鹼',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['ephedrine'] = {
		label = '麻黃鹼(C10H15NO)',
		weight = 55,
		stack = true,
		close = true,
		description = ''
	},
	['iodine'] = {
		label = '碘(I)',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['jerry'] = {
		label = '塑料罐',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['joint'] = {
		label = '大麻菸',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['lithium'] = {
		label = '鋰(Li)',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['meth'] = {
		label = '冰毒',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['methmix'] = {
		label = '冰毒混合物',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['pcoke'] = {
		label = '古柯鹼(包裝)',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['phosphorus'] = {
		label = '磷(P)',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['pmeth'] = {
		label = '冰毒袋',
		weight = 450,
		stack = true,
		close = true,
		description = ''
	},
	['pseudoephedrine'] = {
		label = '偽麻黃鹼',
		weight = 55,
		stack = true,
		close = true,
		description = ''
	},
	['waterpack'] = {
		label = '水 (15L)',
		weight = 15000,
		stack = true,
		close = true,
		description = ''
	},
	['weed'] = {
		label = '大麻葉',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['weedbud'] = {
		label = '大麻芽',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['diamond'] = {
		label = '鑽石',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['diamondring'] = {
		label = '鑽石戒指',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['dmv_licenes'] = {
		label = '駕駛筆試證書',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['dopebag'] = {
		label = '包封袋',
		weight = 60,
		stack = true,
		close = true,
		description = ''
	},
	['dragon'] = {
		label = '龍',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['drill'] = {
		label = '電鑽',
		weight = 1500,
		stack = true,
		close = true,
		description = ''
	},
	['thermite'] = {
		label = '鋁熱炸藥',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['drive_bike_licenes'] = {
		label = '電單車駕駛執照',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['drive_licenes'] = {
		label = '私家車駕駛執照',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['drive_truck_licenes'] = {
		label = '輕型貨車駕駛執照',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['drpepper'] = {
		label = 'Dr. Pepper',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['drugbags'] = {
		label = '藥袋',
		weight = 350,
		stack = true,
		close = true,
		description = ''
	},
	['drugItem'] = {
		label = 'Black USB-C',
		weight = 350,
		stack = true,
		close = true,
		description = ''
	},
	['drugscales'] = {
		label = '毒品檢驗器',
		weight = 770,
		stack = true,
		close = true,
		description = ''
	},
	['emerald'] = {
		label = '綠寶石',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['endur_nitro'] = {
		label = '耐力NOS',
		weight = 15,
		stack = true,
		close = true,
		description = ''
	},
	['endur_nitro_recipe'] = {
		label = '耐力NOS配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['essence'] = {
		label = '汽油',
		weight = 1500,
		stack = true,
		close = true,
		description = ''
	},
	['event_speaker'] = {
		label = '活動團大聲公',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['eventreviver'] = {
		label = '生命復甦器(活動)',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['fabric'] = {
		label = '布',
		weight = 7,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_angelring'] = {
		label = '天使頭圈',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_angelwing'] = {
		label = 'ปีกสีเงิน',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_angelwing19'] = {
		label = 'ปีกเขียวดำ',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_angelwing2'] = {
		label = 'ปีกสีทอง',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_angelwing3'] = {
		label = 'ปีกสีดำ',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_anglewing'] = {
		label = 'ปีกหมอก',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_arcadeahri'] = {
		label = 'หูฟังอาเคด',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_archertine'] = {
		label = '愛神之箭 (2022 情人節限定)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_bearhat'] = {
		label = 'หมวกหมี',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_birdcooper'] = {
		label = 'นกเกาะไหล่',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_chii'] = {
		label = '小貓頭飾',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_demonwing'] = {
		label = '闇惡魔翅膀',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_dragon'] = {
		label = '寒冰神龍背飾',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_heartpink'] = {
		label = '粉紅心心',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_hellwing'] = {
		label = 'ปีกไฟ',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube_blue'] = {
		label = '小貓耳機 ( 藍 )',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube_green'] = {
		label = '小貓耳機 ( 綠 )',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube_pink'] = {
		label = '小貓耳機 ( 粉紅 )',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube_yellow'] = {
		label = '小貓耳機 ( 黃 )',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube2'] = {
		label = 'หูฟังสีฟ้า',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube22'] = {
		label = 'หูฟังสีชมพู',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube222'] = {
		label = 'หูฟังสีเขียว',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_pcube2222'] = {
		label = 'หูฟังสีเหลือง',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_sadheart'] = {
		label = '心臟 (2022 情人節限定)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_sunglasses'] = {
		label = '8Bit太陽眼鏡',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_valentine'] = {
		label = '閃閃玫瑰花 (2022 情人節限定)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fashion_wingsrender'] = {
		label = 'ปีกเรืองแสง',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fireextinguisher_pack'] = {
		label = '包裝滅火筒',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['firing_system'] = {
		label = '擊發裝置',
		weight = 250,
		stack = true,
		close = true,
		description = ''
	},
	['firstaidkit'] = {
		label = '急救包',
		weight = 225,
		stack = true,
		close = true,
		description = ''
	},
	['fish'] = {
		label = '生魚',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['fish_crude'] = {
		label = '已加工魚',
		weight = 26,
		stack = true,
		close = true,
		description = ''
	},
	['fish_fail'] = {
		label = '加工失敗的魚',
		weight = 27,
		stack = true,
		close = true,
		description = ''
	},
	['fish_recipe'] = {
		label = '魚湯配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fishingbait'] = {
		label = '魚餌',
		weight = 2,
		stack = true,
		close = true,
		description = ''
	},
	['fishingrod'] = {
		label = '釣魚竿',
		weight = 600,
		stack = false,
		close = true,
		description = ''
	},
	['fixkit'] = {
		label = '引擎修車包',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['fixkit_recipe'] = {
		label = '修車包配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['fixtool'] = {
		label = '修理工具',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['flaregun_pack'] = {
		label = '包裝閃光彈槍',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['flashlight'] = {
		label = 'Flashlight',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['flashlight_pack'] = {
		label = '包裝手電筒',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['formula_tube'] = {
		label = 'Formula tube',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_01'] = {
		label = '普通轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_02'] = {
		label = '高級轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_11mcar'] = {
		label = '11月精選車輛轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_accessories_1'] = {
		label = '額外飾物轉蛋 (一)',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_ae86'] = {
		label = 'AE86車輛轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_halloween'] = {
		label = '萬聖節限定轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_legocar'] = {
		label = 'LEGO車輛轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_legosenna'] = {
		label = 'Lego Senna轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_valentineday'] = {
		label = '2021 情人節限定轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gacha_xmas'] = {
		label = '聖誕限定轉蛋',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gangtoken'] = {
		label = '幫主信物',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gas_container'] = {
		label = '氣瓶',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['gazbottle'] = {
		label = '油樽',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['goe_coins'] = {
		label = '貪婪的銀幣',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['goe_coins_clear'] = {
		label = '純潔的銀幣',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['goe_coins_clear_eve'] = {
		label = '純潔的銀幣(活動)',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['gold'] = {
		label = '金(Au)',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['gold_wire'] = {
		label = '金線',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['golden_egg'] = {
		label = 'Golden Egg',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['golem'] = {
		label = 'Golem',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['golfclub_pack'] = {
		label = '包裝高爾夫球桿',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['gps'] = {
		label = 'GPS追蹤器(警用)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['gps_chip'] = {
		label = 'GPS晶片',
		weight = 20,
		stack = true,
		close = true,
		description = ''
	},
	['gps_recipe'] = {
		label = 'GPS追蹤器配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['green_phone'] = {
		label = '智能手機(綠色)',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['grip'] = {
		label = 'Grip',
		weight = 2,
		stack = true,
		close = true,
		description = ''
	},
	['gunbarrel_l'] = {
		label = '長型槍管',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['gunbarrel_s'] = {
		label = '短型槍管',
		weight = 350,
		stack = true,
		close = true,
		description = ''
	},
	['gunpowder'] = {
		label = '火藥',
		weight = 105,
		stack = true,
		close = true,
		description = ''
	},
	['hacker_device'] = {
		label = '黑客設備',
		weight = 700,
		stack = true,
		close = true,
		description = ''
	},
	['hammer_pack'] = {
		label = '包裝鐵鎚',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['hatchet_pack'] = {
		label = '包裝斧頭',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['heavypistol_pack'] = {
		label = '包裝重型手槍',
		weight = 600,
		stack = true,
		close = true,
		description = ''
	},
	['hifi'] = {
		label = 'HiFi',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['hifi_frame'] = {
		label = 'HiFi外框',
		weight = 5,
		stack = true,
		close = true,
		description = ''
	},
	['high_alloy'] = {
		label = '高級合金',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['high_bulletproof'] = {
		label = '復合防彈背心',
		weight = 1400,
		stack = true,
		close = true,
		description = ''
	},
	['high_ceramics'] = {
		label = '強化陶瓷',
		weight = 900,
		stack = true,
		close = true,
		description = ''
	},
	['high_fuel_filter'] = {
		label = 'NOS耐用增壓器',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['highgradefemalepoppyseed'] = {
		label = '雌性罌粟籽+',
		weight = 30,
		stack = true,
		close = true,
		description = ''
	},
	['highgradefemaleseed'] = {
		label = '雌性大麻種子+',
		weight = 30,
		stack = true,
		close = true,
		description = ''
	},
	['highgradefert'] = {
		label = '高等 - 肥料',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['highgrademalepoppyseed'] = {
		label = '雄性罌粟籽+',
		weight = 30,
		stack = true,
		close = true,
		description = ''
	},
	['highgrademaleseed'] = {
		label = '雄性大麻種子+',
		weight = 30,
		stack = true,
		close = true,
		description = ''
	},
	['horn'] = {
		label = '喇叭',
		weight = 20,
		stack = true,
		close = true,
		description = ''
	},
	['horn_diaphragm'] = {
		label = '喇叭振膜',
		weight = 20,
		stack = true,
		close = true,
		description = ''
	},
	['housing_license'] = {
		label = '建築牌照',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['hqscale'] = {
		label = '優質檢驗器',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['ice'] = {
		label = '冰',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['ipad'] = {
		label = 'iPad',
		weight = 580,
		stack = true,
		close = true,
		description = ''
	},
	['iron'] = {
		label = '鐵(Fe)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['ironoxide'] = {
		label = '氧化鐵(FeO)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['jager'] = {
		label = 'J?germeister',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['jagerbomb'] = {
		label = 'Jägerbomb',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['jagercerbere'] = {
		label = 'Jägermeister',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['jeton'] = {
		label = 'Jeton',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['jewels'] = {
		label = '珠寶(贓物)',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['jusfruit'] = {
		label = '果汁',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['knife_pack'] = {
		label = '包裝小刀',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['laser_drill'] = {
		label = 'Laser Drill',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['leather'] = {
		label = '皮革',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['licenseplate'] = {
		label = '自訂車牌',
		weight = 5,
		stack = true,
		close = true,
		description = ''
	},
	['lighter'] = {
		label = '打火機',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['limonade'] = {
		label = '檸檬水',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['liquid_oxygen'] = {
		label = '液態氧(LO2)',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['lowgradefemalepoppyseed'] = {
		label = '雌性罌粟籽',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['lowgradefemaleseed'] = {
		label = '雌性大麻種子',
		weight = 30,
		stack = true,
		close = true,
		description = ''
	},
	['lowgradefert'] = {
		label = '低等 - 肥料',
		weight = 150,
		stack = true,
		close = true,
		description = ''
	},
	['lowgradefert_recipe'] = {
		label = '低等 - 肥料配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['lowgrademalepoppyseed'] = {
		label = '雄性罌粟籽',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['lowgrademaleseed'] = {
		label = '雄性大麻種子',
		weight = 30,
		stack = true,
		close = true,
		description = ''
	},
	['magazine_l'] = {
		label = '大型彈匣',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['magazine_m'] = {
		label = '中型彈匣',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['magazine_s'] = {
		label = '小型彈匣',
		weight = 350,
		stack = true,
		close = true,
		description = ''
	},
	['manganese'] = {
		label = '錳(Mn)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['martini'] = {
		label = 'White Martini',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['meat'] = {
		label = '牛肉',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['meat_beef'] = {
		label = '優質牛扒',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['meat_beef_real'] = {
		label = '極上·真·伊甸牛扒',
		weight = 888,
		stack = true,
		close = true,
		description = ''
	},
	['medikit'] = {
		label = '急救包',
		weight = 225,
		stack = true,
		close = true,
		description = ''
	},
	['medikit_recipe'] = {
		label = '急救包配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['metal'] = {
		label = '鐵錠',
		weight = 150,
		stack = true,
		close = true,
		description = ''
	},
	['metalscrap'] = {
		label = '金屬廢料',
		weight = 75,
		stack = true,
		close = true,
		description = ''
	},
	['meth_packaged'] = {
		label = 'Packaged Meth',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['meth_pooch'] = {
		label = '包裝冰毒',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['meth_raw'] = {
		label = 'Raw Meth',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['meth10g'] = {
		label = '冰毒 (1KG)',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['methbrick'] = {
		label = '冰毒磚 (10KG)',
		weight = 10000,
		stack = true,
		close = true,
		description = ''
	},
	['metreshooter'] = {
		label = 'Shooter meter',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['militarypermit'] = {
		label = '軍備許可證',
		weight = 15,
		stack = true,
		close = true,
		description = ''
	},
	['mixapero'] = {
		label = 'Aperitif Mix',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['mojito'] = {
		label = 'Mojito',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['moneybox_crashed'] = {
		label = '錢箱(已染色)',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['moneybox_safe'] = {
		label = '錢箱(未染色)',
		weight = 999,
		stack = true,
		close = true,
		description = ''
	},
	['moonshine'] = {
		label = '走私釀酒',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['moonshine_pooch'] = {
		label = '樽裝走私釀酒',
		weight = 600,
		stack = true,
		close = true,
		description = ''
	},
	['morphine'] = {
		label = 'Morphine',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			consume = 0,
			disable = { move = false, car = true, combat = true },
			-- usetime = 1000,
		}
	},
	['muzzle_l'] = {
		label = '大型槍口',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['muzzle_m'] = {
		label = '中型槍口',
		weight = 150,
		stack = true,
		close = true,
		description = ''
	},
	['muzzle_s'] = {
		label = '小型槍口',
		weight = 125,
		stack = true,
		close = true,
		description = ''
	},
	['nightstick_pack'] = {
		label = '包裝警棍',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['nos_filter'] = {
		label = 'NOS強力增壓器',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['nos_nitrous_bottle'] = {
		label = 'NOS氮氧氣瓶',
		weight = 555,
		stack = true,
		close = true,
		description = ''
	},
	['opium'] = {
		label = '鴉片',
		weight = 60,
		stack = true,
		close = true,
		description = ''
	},
	['opium_pooch'] = {
		label = '包裝鴉片',
		weight = 60,
		stack = true,
		close = true,
		description = ''
	},
	['oxygen'] = {
		label = '氧氣(O2)',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['oxygen_mask'] = {
		label = '氧氣罩',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['packaged_chicken'] = {
		label = '雞柳',
		weight = 350,
		stack = true,
		close = true,
		description = ''
	},
	['packaged_chicken_crude'] = {
		label = '已加工雞柳',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['packaged_chicken_fail'] = {
		label = '加工失敗的雞柳',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['packaged_chicken_recipe'] = {
		label = '炸雞排配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['packaged_plank'] = {
		label = '包裝木材',
		weight = 150,
		stack = true,
		close = true,
		description = ''
	},
	['painkiller'] = {
		label = '止痛藥',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painkiller_l'] = {
		label = '極強快速止痛藥',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painkiller_m'] = {
		label = '布洛芬止痛藥',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painkiller_mo'] = {
		label = '嗎啡',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painkiller_recipe'] = {
		label = '止痛藥配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painkiller_s'] = {
		label = '鎮痛藥',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painting_1'] = {
		label = 'Tier 1 Painting',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painting_2'] = {
		label = 'Tier 2 Painting',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['painting_3'] = {
		label = 'Tier 3 Painting',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['pdw_pack'] = {
		label = '包裝UMP .45',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['petrol'] = {
		label = '油',
		weight = 600,
		stack = true,
		close = true,
		description = ''
	},
	['petrol_raffin'] = {
		label = '加工油',
		weight = 640,
		stack = true,
		close = true,
		description = ''
	},
	['pileofmeds'] = {
		label = '一堆藥',
		weight = 20,
		stack = true,
		close = true,
		description = ''
	},
	['pileofmeds_recipe'] = {
		label = '一堆藥配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['pipewrench_pack'] = {
		label = '包裝管鉗扳手',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['pistol_pack'] = {
		label = '包裝手槍',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['pistol50_pack'] = {
		label = '包裝.50口徑手槍',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['plantpot'] = {
		label = '花盆',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['plastic'] = {
		label = '塑料',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['polymer'] = {
		label = '聚合物',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['poppy'] = {
		label = '罌粟花',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['poppy_recipe'] = {
		label = '罌粟花配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['power_nitro'] = {
		label = '強力NOS',
		weight = 15,
		stack = true,
		close = true,
		description = ''
	},
	['power_nitro_recipe'] = {
		label = '強力NOS配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['presspass'] = {
		label = '政府認可記者證',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['pumpshotgun_pack'] = {
		label = '包裝防暴槍',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['purifiedwater'] = {
		label = '純淨水',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['rasperry'] = {
		label = 'Rasperry',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['rhum'] = {
		label = 'Rhum',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['rhumcoca'] = {
		label = 'Rhum-coke',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['rhumfruit'] = {
		label = 'Rhum-fruit juice',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['rifle_body'] = {
		label = '步槍槍體',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['rolpaper'] = {
		label = '捲紙',
		weight = 20,
		stack = true,
		close = true,
		description = ''
	},
	['rubber'] = {
		label = '橡膠',
		weight = 3,
		stack = true,
		close = true,
		description = ''
	},
	['ruby'] = {
		label = '紅寶石',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['sapphire'] = {
		label = '藍寶石',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['saucisson'] = {
		label = '香腸',
		weight = 40,
		stack = true,
		close = true,
		description = ''
	},
	['scope'] = {
		label = 'Scope',
		weight = 25,
		stack = true,
		close = true,
		description = ''
	},
	['scrap'] = {
		label = '廢鐵',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},
	['Seal'] = {
		label = 'กระเป๋าแมวน้ำ',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['semi_auto_body'] = {
		label = '半自動槍體',
		weight = 299,
		stack = true,
		close = true,
		description = ''
	},
	['shovel'] = {
		label = '鏟子',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['silicon'] = {
		label = '矽(Si)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['skin'] = {
		label = 'Skin',
		weight = 2,
		stack = true,
		close = true,
		description = ''
	},
	['slaughtered_chicken'] = {
		label = '已屠宰的雞',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['smg_body'] = {
		label = 'SMG槍體',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['smg_pack'] = {
		label = 'H&K MP5',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['sniperrifle_pack'] = {
		label = '包裝狙擊槍',
		weight = 3000,
		stack = true,
		close = true,
		description = ''
	},
	['snspistol_pack'] = {
		label = '包裝劣質手槍',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['soda'] = {
		label = '蘇打水',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['sorted_money'] = {
		label = 'Counterfeit Cash - Sorted',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['speaker'] = {
		label = '大聲公',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['speaker_recipe'] = {
		label = '大聲公配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['spring'] = {
		label = '彈簧',
		weight = 6,
		stack = true,
		close = true,
		description = ''
	},
	['stannum'] = {
		label = '錫(Sn)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['steak'] = {
		label = 'Steak',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['steel'] = {
		label = '鋼',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['stomatopods'] = {
		label = '瀨尿蝦',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['stomatopods_great'] = {
		label = '醬爆瀨尿牛丸',
		weight = 55,
		stack = true,
		close = true,
		description = ''
	},
	['stomatopods_poor'] = {
		label = '凱婷牛丸',
		weight = 55,
		stack = true,
		close = true,
		description = ''
	},
	['stomatopods_recipe'] = {
		label = '瀨尿牛丸配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['stone'] = {
		label = '石頭',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['stungun_pack'] = {
		label = '包裝電擊槍',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['supressor'] = {
		label = 'Suppressor',
		weight = 30,
		stack = true,
		close = true,
		description = ''
	},
	['teqpaf'] = {
		label = 'Teqpaf',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['trimmedweed'] = {
		label = '修剪過的大麻',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['tyre'] = {
		label = '可更換的車胎',
		weight = 700,
		stack = true,
		close = true,
		description = ''
	},
	['tyre_recipe'] = {
		label = '可更換的車胎配方',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['uncutgem'] = {
		label = '原鑚',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['vodkaenergy'] = {
		label = 'Vodka-energy',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['vodkafruit'] = {
		label = 'Vodka-fruit juice',
		weight = 50,
		stack = true,
		close = true,
		description = ''
	},
	['washed_stone'] = {
		label = '洗過的石頭',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['waste'] = {
		label = '廚餘',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},
	['wateringcan'] = {
		label = '水壺',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['weed_packaged'] = {
		label = 'Packaged Weed',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['weed_pooch'] = {
		label = '包裝大麻',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['weed_untrimmed'] = {
		label = 'Untrimmed Weed',
		weight = 500,
		stack = true,
		close = true,
		description = ''
	},
	['weed10g'] = {
		label = '大麻 (1KG)',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['weedbrick'] = {
		label = '大麻磚 (10KG)',
		weight = 10000,
		stack = true,
		close = true,
		description = ''
	},
	['wheel'] = {
		label = 'Wheel',
		weight = 2000,
		stack = true,
		close = true,
		description = ''
	},
	['whiskycoca'] = {
		label = 'Whisky-coke',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['white_phone'] = {
		label = '智能手機(白色)',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['winch'] = {
		label = 'Winch',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['wing_gb_blue'] = {
		label = 'ปีกฟ้า',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['wing_gb_green'] = {
		label = 'ปีกเขียว',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['wing_gb_pink'] = {
		label = 'ปีกชมพู',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['wood'] = {
		label = '木',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},
	['wool'] = {
		label = '羊毛',
		weight = 200,
		stack = true,
		close = true,
		description = ''
	},
	['worktablet'] = {
		label = 'CCTV工作平板',
		weight = 1000,
		stack = true,
		close = true,
		description = ''
	},
	['yusuf'] = {
		label = 'Luxushaut',
		weight = 10,
		stack = true,
		close = true,
		description = ''
	},
	['zinc'] = {
		label = '鋅(Zn)',
		weight = 100,
		stack = true,
		close = true,
		description = ''
	},

	['identification'] = {
		label = '身份證',
		weight = 10,
		stack = false,
		close = true,
		client = {
			consume = 0,
			disable = { move = false, car = true, combat = true },
			-- usetime = 1000,
		}
	},

	['drivers_license'] = {
		label = '駕駛執照',
		weight = 10,
		stack = false,
		close = true,
		client = {
			consume = 0,
			disable = { move = false, car = true, combat = true },
			-- usetime = 1000,

		}
	},

	['firearms_license'] = {
		label = '槍械執照',
		weight = 10,
		stack = false,
		close = true,
		client = {
			consume = 0,
			disable = { move = false, car = true, combat = true },
			-- usetime = 1000,
		}
	},

	['christmassnowman'] = {
		label = '雪人',
		weight = 10,
		stack = false,
		close = true,
		client = {
			consume = 0,
			event = 'rtx_christmas:UseSnowMan',
		}
	},

	['christmasigloo'] = {
		label = '雪屋',
		weight = 10,
		stack = false,
		close = true,
		client = {
			consume = 0,
			event = 'rtx_christmas:UseIgloo',
		}
	},

	['christmastree'] = {
		label = '樹',
		weight = 10,
		stack = false,
		close = true,
		client = {
			consume = 0,
			event = 'rtx_christmas:UseTree',
		}
	},

	['christmasdecorativebells'] = {
		label = '鈴',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmasdecorativelightsyellow'] = {
		label = 'Yellow lights',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmasdecorativelightsred'] = {
		label = 'Red lights',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmasdecorativelightswhite'] = {
		label = 'White lights',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmasdecorativeballsyellow'] = {
		label = '黃色球',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmasdecorativeballsred'] = {
		label = '紅色鈴',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmasdecorativestar'] = {
		label = '星星',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmasdecorativecandy'] = {
		label = '糖果',
		weight = 10,
		stack = false,
		close = true,
	},

	['christmassnow'] = {
		label = '雪',
		weight = 10,
		stack = false,
		close = true
	},

	['christmassnowball'] = {
		label = '雪球',
		weight = 10,
		stack = false,
		close = true
	},

	['gacha_old_fashion'] = {
		label = '懷舊飾品轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['mall_ticket_88'] = {
		label = '商城點數兌換卷 (88點)',
		weight = 1,
		stack = true,
		close = true,
	},
	['mall_ticket_188'] = {
		label = '商城點數兌換卷 (188點)',
		weight = 1,
		stack = true,
		close = true,
	},
	['mall_ticket_288'] = {
		label = '商城點數兌換卷 (288點)',
		weight = 1,
		stack = true,
		close = true,
	},
	['mall_ticket_388'] = {
		label = '商城點數兌換卷 (388點)',
		weight = 1,
		stack = true,
		close = true,
	},
	['mall_ticket_18'] = {
		label = '商城點數兌換卷 (18點)',
		weight = 1,
		stack = true,
		close = true,
	},
	['mall_ticket_68'] = {
		label = '商城點數兌換卷 (68點)',
		weight = 1,
		stack = true,
		close = true,
	},
	['red_pocket_2022'] = {
		label = '2022 新年利是',
		weight = 1,
		stack = true,
		close = true
	},
	['red_pocket_2022_premium'] = {
		label = '2022 新年利是 Premium+',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_2022_valentines_heart_head'] = {
		label = '情人節快樂頭飾 (2022 情人節限定)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_2022_heartbag_pink'] = {
		label = '心心背包 (2022 情人節限定)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_2022_valentines_pinkrose_valentine'] = {
		label = '粉紅玫瑰 (2022 情人節限定)',
		weight = 1,
		stack = true,
		close = true
	},
	['gacha_valentineday_2022'] = {
		label = '2022 情人節限定轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['akm_repair'] = {
		label = '包裝 AKM 7.62x39',
		weight = 2100,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = true, combat = true },
			usetime = 0,
		},
		server = {
			msg = '已拆開包裝',
		}
	},
	['m9a3_repair'] = {
		label = '包裝 Beretta M9A3 9x19',
		weight = 2100,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = true, combat = true },
			usetime = 0,
		},
		server = {
			msg = '已拆開包裝',
		}
	},
	['carbine_repair'] = {
		label = '包裝卡賓步槍',
		weight = 2100,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = true, combat = true },
			usetime = 0,
		},
		server = {
			msg = '已拆開包裝',
		}
	},
	['doubleaction_repair'] = {
		label = '包裝左輪手槍',
		weight = 2100,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = true, combat = true },
			usetime = 0,
		},
		server = {
			msg = '已拆開包裝',
		}
	},
	['heavy_repair'] = {
		label = '包裝重型手槍',
		weight = 2100,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = true, combat = true },
			usetime = 0,
		},
		server = {
			msg = '已拆開包裝',
		}
	},
	['stunshotgun_repair'] = {
		label = '包裝防暴槍',
		weight = 2100,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = true, combat = true },
			usetime = 0,
		},
		server = {
			msg = '已拆開包裝',
		}
	},
	['stungun_repair'] = {
		label = '包裝電擊槍',
		weight = 227,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = true, combat = true },
			usetime = 0,
		},
		server = {
			msg = '已拆開包裝',
		}
	},
	['wea_repairkit'] = {
		label = '武器維修包',
		weight = 500,
		stack = true,
		close = true,
		description = '武器維修包(民用)'
	},
	['wea_repairkit_pol'] = {
		label = '武器維修包',
		weight = 500,
		stack = true,
		close = true,
		description = '武器維修包(警用)'
	},
	['fashion_handfire_red'] = {
		label = '火火 (紅)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_handfire_pink'] = {
		label = '火火 (粉紅)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_handfire_gold'] = {
		label = '火火 (金)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_handfire_rainbow'] = {
		label = '火火 (彩虹)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_handfire_purple'] = {
		label = '火火 (紫)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_handfire_green_l'] = {
		label = '火火 (綠)',
		weight = 1,
		stack = true,
		close = true
	},
	['lego_car_gachanpon_1'] = {
		label = 'Lego 車輛轉蛋 1',
		weight = 1,
		stack = true,
		close = true
	},
	['lego_car_gachanpon_1_guarantee'] = {
		label = 'Lego 車輛轉蛋 1 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['lego_car_gachanpon_2'] = {
		label = 'Lego 車輛轉蛋 2',
		weight = 1,
		stack = true,
		close = true
	},
	['lego_car_gachanpon_2_guarantee'] = {
		label = 'Lego 車輛轉蛋 2 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_beta_player_title_1'] = {
		label = '封測玩家稱號',
		weight = 1,
		stack = true,
		close = true
	},
	['fireworks'] = {
		label = '煙火發射器',
		weight = 1,
		stack = true,
		close = true
	},
	['firework'] = {
		label = '煙火',
		weight = 1,
		stack = true,
		close = true
	},
	['casino_chips'] = {
		label = '賭場籌碼',
		weight = 0.1,
		stack = true,
		close = true
	},
	['casino_tickets'] = {
		label = '賭場轉盤兌換卷',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_magic_circle_1'] = {
		label = '咕嚕咕嚕魔法陣 (黃)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_magic_circle_2'] = {
		label = '咕嚕咕嚕魔法陣 (紅)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_melody'] = {
		label = '唔~該~你~阿 Melody',
		weight = 1,
		stack = true,
		close = true
	},
	['magic_circle_gachanpon'] = {
		label = '咕嚕咕嚕轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['magic_circle_gachanpon_guarantee'] = {
		label = '咕嚕咕嚕轉蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_doggy_1'] = {
		label = '法鬥狗勾',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_kuromi'] = {
		label = 'Kuromi',
		weight = 1,
		stack = true,
		close = true
	},
	['puipui_gachanpon'] = {
		label = '天竺鼠車車轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['puipui_gachanpon_guarantee'] = {
		label = '天竺鼠車車轉蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},

	['cheese'] = {
		label = '芝士',
		weight = 50,
		stack = true,
		close = true
	},
	['lettuce'] = {
		label = '生菜',
		weight = 100,
		stack = true,
		close = true
	},
	['tomate'] = {
		label = '番茄',
		weight = 200,
		stack = true,
		close = true
	},
	['fruit_pack'] = {
		label = '水果拼盤',
		weight = 300,
		stack = true,
		close = true
	},
	['mustard'] = {
		label = '芥末',
		weight = 20,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			-- usetime = 2500,
		}
	},
	['water'] = {
		label = '水',
		weight = 300,
		client = {
			status = { thirst = 100000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			-- usetime = 2500,
			cancel = true
		}
	},
	['absinthe'] = {
		label = '苦艾酒',
		weight = 200,
		stack = true,
		close = true,
		description = '',
		client = {
			status = { drunk = 300 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_bottle_cognac`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['beer'] = {
		label = '啤酒',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -10000, drunk = 60 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_amb_beer_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['bread'] = {
		label = '麵包',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { hunger = 100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['champagne'] = {
		label = '香檳',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { drunk = 35 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_wine_white`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['chocolate'] = {
		label = '古古力',
		weight = 150,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -5000, hunger = 100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_choc_ego`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['cocacola'] = {
		label = '可口可樂',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 100000, hunger = 5000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['coffe'] = {
		label = '咖啡',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 100000, hunger = 5000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_fib_coffee`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['cupcake'] = {
		label = '杯子蛋糕',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -5000, hunger = 100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `ng_proc_food_ornge1a`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['fish_great'] = {
		label = '美味魚湯',
		weight = 666,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 1000000, hunger = 20000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['fish_normal'] = {
		label = '魚湯',
		weight = 444,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 350000, hunger = 10000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['fish_poor'] = {
		label = '噁心魚湯',
		weight = 555,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 140000, drunk = 20 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['gintonic'] = {
		label = '主席的愛',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { drunk = 100 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_rum_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['hamburger'] = {
		label = '漢堡包',
		weight = 300,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -5000, hunger = 100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['icetea'] = {
		label = '凍撚死',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 100000, hunger = 5000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['milk'] = {
		label = '新鮮牛奶',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 100000, drunk = -100 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_milk_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['miso_soup_great'] = {
		label = '極致一樂麵豉湯',
		weight = 500,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 1000000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['miso_soup_normal'] = {
		label = '一般一樂麵豉湯',
		weight = 300,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['miso_soup_poor'] = {
		label = '噁心一樂麵豉湯',
		weight = 200,
		stack = true,
		close = true,
		description = '',
		client = {
			status = { thirst = 140000, drunk = 20 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['packaged_chicken_great'] = {
		label = '美味炸雞排',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -35000, hunger = 500000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['packaged_chicken_normal'] = {
		label = '炸雞排',
		weight = 150,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -70000, hunger = 350000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['packaged_chicken_poor'] = {
		label = '炸焦雞排',
		weight = 150,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -140000, hunger = 140000, drunk = 20 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['ramen_ichiraku_great'] = {
		label = '極致一樂叉燒拉麵',
		weight = 500,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { hunger = 500000, thirst = -35000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['ramen_ichiraku_normal'] = {
		label = '一般一樂叉燒拉麵',
		weight = 300,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { hunger = 350000, thirst = -70000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['ramen_ichiraku_poor'] = {
		label = '噁心一樂叉燒拉麵',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { hunger = 140000, thirst = -140000, drunk = 20 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bowl_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['sandwich'] = {
		label = '三文治',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -5000, hunger = 100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_sandwich_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['tequila'] = {
		label = '龍舌蘭酒',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -10000, drunk = 140 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_tequila_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['vodka'] = {
		label = '伏特加酒',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -10000, drunk = 60 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_vodka_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['whiskey'] = {
		label = '威士忌',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -10000, drunk = 60 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_cs_whiskey_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['wine'] = {
		label = '葡萄酒',
		weight = 200,
		stack = true,
		close = false,
		description = '',
		client = {
			status = { thirst = -10000, drunk = 60 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_wine_bot_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['fanta'] = {
		label = '芬達',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['chicken_meat_cooked'] = {
		label = '煎雞排',
		weight = 200,
		stack = true,
		close = true,
		client = {
			status = { hunger = 100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['chickenburger'] = {
		label = '調理脆辣雞腿包',
		weight = 300,
		stack = true,
		close = true,
		client = {
			status = { hunger = 250000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['chickenburgermenu'] = {
		label = '調理脆辣雞腿包餐',
		weight = 400,
		stack = true,
		close = true,
		client = {
			status = { thirst = 1000000, hunger = 1000000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['fish_cooked'] = {
		label = '調理脆香魚柳',
		weight = 150,
		stack = true,
		close = true,
		client = {
			status = { hunger = 150000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['fashion_pooh_pig'] = {
		label = '豬仔',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_pooh_tiger'] = {
		label = '跳跳虎',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_pooh_small'] = {
		label = '維尼頭飾',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_pooh_big'] = {
		label = '維尼背飾',
		weight = 1,
		stack = true,
		close = true
	},
	['winniethepooh_gachanpon'] = {
		label = '維尼含家拎轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['winniethepooh_gachanpon_guarantee'] = {
		label = '維尼含家拎轉蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['fertilizer'] = {
		label = 'Fertilizer',
		weight = 1,
		stack = true,
		close = true
	},
	['soil'] = {
		label = 'Soil',
		weight = 1,
		stack = true,
		close = true
	},
	['someotherstrain_buds'] = {
		label = 'Some Other Strain Buds',
		weight = 1,
		stack = true,
		close = true
	},
	['someotherstrain_leaves'] = {
		label = 'Some Other Strain Leaves',
		weight = 1,
		stack = true,
		close = true
	},
	['someotherstrain_seed_f'] = {
		label = 'Some Other Strain (F)',
		weight = 1,
		stack = true,
		close = true
	},
	['someotherstrain_seed_m'] = {
		label = 'Some Other Strain (M)',
		weight = 1,
		stack = true,
		close = true
	},
	['someotherstrain_seed_u'] = {
		label = 'Some Other Strain (U)',
		weight = 1,
		stack = true,
		close = true
	},
	['somestrain_buds'] = {
		label = 'Some Strain Buds',
		weight = 1,
		stack = true,
		close = true
	},
	['somestrain_leaves'] = {
		label = 'Some Strain Leaves',
		weight = 1,
		stack = true,
		close = true
	},
	['somestrain_seed_f'] = {
		label = 'Some Strain (F)',
		weight = 1,
		stack = true,
		close = true
	},
	['somestrain_seed_m'] = {
		label = 'Some Strain (M)',
		weight = 1,
		stack = true,
		close = true
	},
	['somestrain_seed_u'] = {
		label = 'Some Strain (U)',
		weight = 1,
		stack = true,
		close = true
	},
	['water_bottle'] = {
		label = 'Water Bottle',
		weight = 1,
		stack = true,
		close = true
	},
	['spray'] = {
		label = '噴漆',
		weight = 10,
		stack = true,
		close = false,
	},

	['spray_remover'] = {
		label = '噴漆移除劑',
		weight = 10,
		stack = true,
		close = false,
		client = {
			event = "rcore_spray:removeClosestSpray"
		}
	},
	['fashion_8bit_heart_glass'] = {
		label = '8Bit 心心眼鏡',
		weight = 10,
		stack = true,
		close = false,
	},

	['fashion_durfwing'] = {
		label = '晴空飛飛',
		weight = 10,
		stack = true,
		close = false,
	},
	['fashion_ghoulehead'] = {
		label = '惡魔角角',
		weight = 10,
		stack = true,
		close = false,
	},
	['flyfly_gachanpon'] = {
		label = '晴空飛飛轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['flyfly_gachanpon_guarantee'] = {
		label = '晴空飛飛轉蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['burgershot_minions_icecream'] = {
		label = '迷你兵團X香蕉船',
		weight = 300,
		stack = true,
		close = true,
		client = {
			status = { stamina_buff = 30, thirst = -100000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_food_bs_burg3`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['burgershot_pineapple_burger'] = {
		label = '菠蘿滋味雞堡',
		weight = 300,
		stack = true,
		close = true,
		client = {
			status = { hunger = 250000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},

	['burgershot_pineapple_burger_set'] = {
		label = '菠蘿滋味雞堡餐',
		weight = 400,
		stack = true,
		close = true,
		client = {
			status = { thirst = 1000000, hunger = 1000000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			-- usetime = 2500,
		}
	},
	['burgershot_fruit_punch'] = {
		label = '雜果賓治',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 100000 },
			anim = { dict = 'amb@code_human_wander_drinking@beer@male@base', clip = 'static' },
			prop = { model = `prop_food_bs_juice01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			-- usetime = 2500,
		}
	},
	['burgershot_chicken_fillet'] = {
		label = '煎雞柳',
		weight = 100,
		stack = true,
		close = true,
	},
	['burgershot_pineapple'] = {
		label = '菠蘿',
		weight = 100,
		stack = true,
		close = true,
	},
	['burgershot_icecream'] = {
		label = '雪糕',
		weight = 100,
		stack = true,
		close = true,
	},
	['remote'] = {
		label = '遙控器',
		weight = 50,
		stack = false,
		close = false,
	},
	['event_01_gachanpon'] = {
		label = '金蛋蛋',
		weight = 10,
		stack = true,
		close = true,
	},

	['fashion_black_queen_horn'] = {
		label = '黑皇后角角',
		weight = 10,
		stack = true,
		close = true,
	},
	['fashion_anubis_ears'] = {
		label = '阿努比斯耳耳',
		weight = 10,
		stack = true,
		close = true,
	},
	['fashion_violence_bear'] = {
		label = '暴力啤啤',
		weight = 10,
		stack = true,
		close = true,
	},
	['blackblack_gachanpon'] = {
		label = '黑蚊蚊轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['blackblack_gachanpon_guarantee'] = {
		label = '黑蚊蚊轉蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['watergun'] = {
		label = '水槍',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_duck_swim'] = {
		label = '膠膠鴨水泡',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_pig_swim'] = {
		label = '肥肥豬水泡',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_uni_swim'] = {
		label = '角角馬水泡',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_duck_swimdoll'] = {
		label = '膠膠鴨',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_pig_swimdoll'] = {
		label = '肥肥豬',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_uni_swimdoll'] = {
		label = '角角馬',
		weight = 1,
		stack = true,
		close = true
	},
	['summer_gachanpon'] = {
		label = '夏日蛋蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['summer_gachanpon_guarantee'] = {
		label = '夏日蛋蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['summer_gachanpon_2'] = {
		label = '夏日蛋蛋 2',
		weight = 1,
		stack = true,
		close = true
	},
	['summer_gachanpon_2_guarantee'] = {
		label = '夏日蛋蛋 2 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_lannalight_green'] = {
		label = '燈籠 (綠)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_lannalight_red'] = {
		label = '燈籠 (紅)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_lannalight_yellow'] = {
		label = '燈籠 (黃)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_demonwing2'] = {
		label = '火惡魔翅膀',
		weight = 1,
		stack = true,
		close = true
	},
	['burgershot_strangecandy'] = {
		label = '調理怪味糖',
		weight = 300,
		stack = true,
		close = true,
		consume = 1
	},
	['burgershot_sugar'] = {
		label = '糖',
		weight = 100,
		stack = true,
		close = true
	},
	['burgershot_seasoning'] = {
		label = '奇怪調味料',
		weight = 100,
		stack = true,
		close = true
	},
	['contract'] = {
		label = '載具轉讓合約',
		weight = 100,
		stack = true,
		close = true,
		client = {
			event = 'okokContract:doRequest',
		}
	},
	['midautumn_gachanpon_2022'] = {
		label = '2022 中秋節限定月餅盒',
		weight = 1,
		stack = true,
		close = true
	},
	['midautumn_gachanpon_2022_guarantee'] = {
		label = '2022 中秋節限定月餅盒 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['mooncake_gachanpon'] = {
		label = '月餅 (轉蛋)',
		weight = 1,
		stack = true,
		close = true
	},
	['mooncake'] = {
		label = '月餅',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
		},
	},
	['lockpick_sp'] = {
		label = '解鎖器 (特製)',
		weight = 100,
		stack = true,
		close = true
	},
	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},
	['fashion_rainydoll01'] = {
		label = '天氣天使 (白)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_rainydoll02'] = {
		label = '天氣天使 (粉紅)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_rainydoll03'] = {
		label = '天氣天使 (綠)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_wing_angel01'] = {
		label = '天使翼 (白)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_wing_angel02'] = {
		label = '天氣天使 (綠)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_wing_angel03'] = {
		label = '天氣天使 (紫)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_cloud01'] = {
		label = '白雲 (雨天)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_cloud02'] = {
		label = '白雲 (雷電)',
		weight = 1,
		stack = true,
		close = true
	},
	['fashion_cloud03'] = {
		label = '白雲 (晴天)',
		weight = 1,
		stack = true,
		close = true
	},
	['sunnrain_gachanpon'] = {
		label = '雨後天晴轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['sunnrain_gachanpon_guarantee'] = {
		label = '雨後天晴轉蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},

	['aquamarine'] = {
		label = '海藍寶石',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_aquamarine'] = {
		label = '海藍寶石 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['c4'] = {
		label = 'C4',
		weight = 1,
		stack = true,
		close = true
	},

	['coal'] = {
		label = '煤炭',
		weight = 1,
		stack = true,
		close = true
	},

	['copper_bar'] = {
		label = '銅(條)',
		weight = 2,
		stack = true,
		close = true
	},

	['ds_diamond'] = {
		label = '鑽石',
		weight = 1,
		stack = true,
		close = true
	},

	['gold_bar'] = {
		label = '金條',
		weight = 1,
		stack = true,
		close = true
	},

	['greenberyl'] = {
		label = '綠寶石',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_greenberyl'] = {
		label = '綠寶石 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['lead_ore'] = {
		label = '鉛礦石',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_ruby'] = {
		label = '紅寶石 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['sulfur_bar'] = {
		label = '硫',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_diamond'] = {
		label = '鑽石 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_aluminum'] = {
		label = '鋁土礦 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_coal'] = {
		label = '煤 (未切割)',
		weight = 2,
		stack = true,
		close = true
	},

	['unshapped_copper'] = {
		label = '銅 (未切割)',
		weight = 3,
		stack = true,
		close = true
	},

	['unshapped_gold'] = {
		label = '金 (未切割)',
		weight = 3,
		stack = true,
		close = true
	},

	['unshapped_iron'] = {
		label = '鐵 (未切割)',
		weight = 2,
		stack = true,
		close = true
	},

	['unshapped_lead'] = {
		label = '鉛礦石 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_sulfur'] = {
		label = '硫 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['unwashed_aluminum'] = {
		label = '鋁土礦 (未清洗)',
		weight = 1,
		stack = true,
		close = true
	},

	['unwashed_copper'] = {
		label = '銅 (未清洗)',
		weight = 1,
		stack = true,
		close = true
	},

	['unwashed_gold'] = {
		label = '金 (未清洗)',
		weight = 3,
		stack = true,
		close = true
	},

	['unwashed_iron'] = {
		label = '鐵 (未清洗)',
		weight = 2,
		stack = true,
		close = true
	},

	['unwashed_lead'] = {
		label = '鉛礦石 (未清洗)',
		weight = 1,
		stack = true,
		close = true
	},

	['unwashed_stone'] = {
		label = '金屬廢料 (未清洗)',
		weight = 2,
		stack = true,
		close = true
	},

	['unwashed_sulfur'] = {
		label = '硫 (未清洗)',
		weight = 1,
		stack = true,
		close = true
	},

	['unwashed_stannum'] = {
		label = '錫 (未清洗)',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_stannum'] = {
		label = '錫 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['unwashed_steel'] = {
		label = '鋼 (未清洗)',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_steel'] = {
		label = '鋼 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['unshapped_stone'] = {
		label = '金屬廢料 (未切割)',
		weight = 1,
		stack = true,
		close = true
	},

	['m_drill'] = {
		label = '電鑽(礦工用)',
		weight = 1,
		stack = true,
		close = true
	},

	['fashion_soulhw1'] = {
		label = '驚訝小鬼 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_soulhw2'] = {
		label = '害怕小鬼 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_soulhw3'] = {
		label = '頭暈小鬼 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['fashion_maskhw1'] = {
		label = '惡魔面具 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_maskhw2'] = {
		label = '樹怪面具 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_maskhw3'] = {
		label = '異形面具 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['fashion_eyebathw1'] = {
		label = '紫惡魔眼 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_eyebathw2'] = {
		label = '粉惡魔眼 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_eyebathw3'] = {
		label = '紅惡魔眼 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['fashion_scarecrowhw1'] = {
		label = '南瓜稻草人(藍) (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_scarecrowhw2'] = {
		label = '南瓜稻草人(紅) (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_scarecrowhw3'] = {
		label = '南瓜稻草人(綠) (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['fashion_candyhw1'] = {
		label = '人頭糖果 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_candyhw2'] = {
		label = '南瓜糖果 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
	['fashion_candyhw3'] = {
		label = '蝙蝠糖果 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['fashion_balloonhw1'] = {
		label = '南瓜喵氣球 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['fashion_pumkinhw'] = {
		label = '背飾南瓜手 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['2022_oct_hw_daily_reward'] = {
		label = '10月每日獎勵換領券 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},

	['halloween_gachanpon_2022'] = {
		label = '2022 萬聖節限定轉蛋',
		weight = 1,
		stack = true,
		close = true
	},
	['halloween_gachanpon_2022_guarantee'] = {
		label = '2022 萬聖節限定轉蛋 ( 保證獲得 )',
		weight = 1,
		stack = true,
		close = true
	},
	['gacha_game_hw_2022'] = {
		label = '2022 萬聖節限定遊戲幣轉蛋',
		weight = 1,
		stack = true,
		close = true
	},

	['2022_hw_event_reward'] = {
		label = '活動換領券 (2022 萬聖節限定)',
		weight = 1,
		stack = true,
		close = false
	},
}