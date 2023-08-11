Locales['tc'] = {
  -- Inventory
  ['inventory'] = '背包 %s / %s',
  ['use'] = '使用',
  ['give'] = '給',
  ['remove'] = '丟棄',
  ['return'] = '返回',
  ['give_to'] = '給予',
  ['amount'] = '數量',
  ['giveammo'] = '給予子彈',
  ['amountammo'] = '子彈量',
  ['noammo'] = '您沒有足夠的子彈！',
  ['gave_item'] = '您把~y~%sx~s~~b~%s~s~給予了~y~%s~s~',
  ['received_item'] = '您收到~y~%sx~s~~b~%s~s~，來自~b~%s~s~',
  ['gave_weapon'] = '您把~b~%s~s~給予了~y~%s~s~',
  ['gave_weapon_ammo'] = '您把~o~%sx~s~~b~%s~s~ %s~s~給予了~y~%s~s~',
  ['gave_weapon_withammo'] = '您把~b~%s~s~和~o~%sx~s~ %s~s~給予了~y~%s~s~',
  ['gave_weapon_hasalready'] = '~y~%s~s~已經有~y~%s~s~',
  ['gave_weapon_noweapon'] = '~y~%s~s~沒有那把武器',
  ['received_weapon'] = '您收到了~b~%s~s~，來自~b~%s~s~',
  ['received_weapon_ammo'] = '您收到了~o~%sx~s~ %s~s~(~b~%s~s~)，來自~b~%s~s~',
  ['received_weapon_withammo'] = '您收到了~b~%s~s~和~o~%sx~s~ %s~s~，來自~b~%s~s~',
  ['received_weapon_hasalready'] = '~b~%s~s~嘗試给您~y~%s~s~，但您已经有了',
  ['received_weapon_noweapon'] = '~b~%s~s~嘗試给您~y~%s~s~子彈，但是您沒有那把武器',
  ['gave_account_money'] = '您將 ~g~$%s~s~ (%s) 给予 ~y~%s~s~',
  ['received_account_money'] = '您收到了~g~$%s~s~ (%s) 来自 ~b~%s~s~',
  ['amount_invalid'] = '無效的數量',
  ['players_nearby'] = '附近沒有玩家',
  ['ex_inv_lim'] = '操作失敗, 超過~y~%s~s~物品欄位的限制',
  ['imp_invalid_quantity'] = '操作失敗，無效的數量',
  ['imp_invalid_amount'] = '操作失敗，無效的金額',
  ['threw_standard'] = '您丟棄了~y~%sx~s~~b~%s~s~',
  ['threw_account'] = '您丟棄了~g~$%s~s~~b~%s~s~',
  ['threw_weapon'] = '您丟棄了~b~%s~s~',
  ['threw_weapon_ammo'] = '您丟棄了~b~%s~s~和~o~%sx%s~s~',
  ['threw_weapon_already'] = '您已經有相同的武器了',
  ['threw_cannot_pickup'] = '您不能再撿起該物品，因為您的背包已經滿了',
  ['threw_pickup_prompt'] = '按下 ~y~E~s~ 撿起',

  -- Key mapping
  ['keymap_showinventory'] = '顯示背包',

  -- Salary related
  ['received_salary'] = '您收到您的薪水: ~g~$%s~s~',
  ['received_help'] = '你領取到了你的失業救濟金: ~g~$%s~s~',
  ['company_nomoney'] = '您的公司太窮了，無法給予您薪水。',
  ['received_paycheck'] = '收到轉帳',
  ['bank'] = '花園銀行',
  ['account_bank'] = '銀行',
  ['account_black_money'] = '黑錢',
  ['account_money'] = '現金',

  ['act_imp'] = '操作失敗',
  ['in_vehicle'] = '請離開載具',

  -- Commands
  ['command_car'] = '生成載具',
  ['command_car_car'] = '生成載具的模型名稱或希哈值',
  ['command_cardel'] = '刪除附近的載具',
  ['command_cardel_radius'] = '可選擇，刪除指定半徑內的所有車輛',
  ['command_clear'] = '清除聊天紀錄',
  ['command_clearall'] = '清除所有玩家的聊天紀錄',
  ['command_clearinventory'] = '清除玩家背包',
  ['command_clearloadout'] = '清除玩家人物造型',
  ['command_giveaccountmoney'] = '給予帳戶錢',
  ['command_giveaccountmoney_account'] = '有效的帳戶名稱',
  ['command_giveaccountmoney_amount'] = '添加的數量',
  ['command_giveaccountmoney_invalid'] = '無效的帳戶名稱',
  ['command_giveitem'] = '給玩家一個物品',
  ['command_giveitem_item'] = '物品名稱',
  ['command_giveitem_count'] = '物品數量',
  ['command_giveweapon'] = '给玩家一把武器',
  ['command_giveweapon_weapon'] = '武器名稱',
  ['command_giveweapon_ammo'] = '子彈數量',
  ['command_giveweapon_hasalready'] = '該玩家已經擁有了該武器',
  ['command_giveweaponcomponent'] = '給予武器配件',
  ['command_giveweaponcomponent_component'] = '配件名稱',
  ['command_giveweaponcomponent_invalid'] = '無效的武器配件',
  ['command_giveweaponcomponent_hasalready'] = '該玩家已經擁有了武器配件',
  ['command_giveweaponcomponent_missingweapon'] = '該玩家沒有那把武器',
  ['command_save'] = '保存玩家數據至資料庫',
  ['command_saveall'] = '保存所有玩家數據至資料庫',
  ['command_setaccountmoney'] = '為玩家設置賬戶資金',
  ['command_setaccountmoney_amount'] = '要設置的金額',
  ['command_setcoords'] = '傳送到座標上',
  ['command_setcoords_x'] = 'x 軸',
  ['command_setcoords_y'] = 'y 軸',
  ['command_setcoords_z'] = 'z 軸',
  ['command_setjob'] = '設定該玩家職業',
  ['command_setjob_job'] = '職業名稱',
  ['command_setjob_grade'] = '職業階級',
  ['command_setjob_invalid'] = '職業、階級或者兩者都無效',
  ['command_setgroup'] = '設定玩家群組階級',
  ['command_setgroup_group'] = '玩家群組階級名稱',
  ['commanderror_argumentmismatch'] = '參數數量不正確（該類型為%s, 需要給予 %s）',
  ['commanderror_argumentmismatch_number'] = '參數 #%s 類型不匹配（該類型為字串，需要給予的數字類型）',
  ['commanderror_invaliditem'] = '無效的物品名稱',
  ['commanderror_invalidweapon'] = '無效武器',
  ['commanderror_console'] = '該指令不能從控制台執行',
  ['commanderror_invalidcommand'] = '^3%s^0 不是有效的指令！',
  ['commanderror_invalidplayerid'] = '無效的玩家ID',
  ['commandgeneric_playerid'] = '玩家id',

  -- Locale settings
  ['locale_digit_grouping_symbol'] = ',',
  ['locale_currency'] = '$%s',

  -- Weapons
  
  -- Melee
  ['weapon_dagger'] = '匕首',
  ['weapon_bat'] = '棒球棍',
  ['weapon_battleaxe'] = '戰斧',
  ['weapon_bottle'] = '酒瓶',
  ['weapon_crowbar'] = '撬棍',
  ['weapon_flashlight'] = '手電筒',
  ['weapon_golfclub'] = '高爾夫球棍',
  ['weapon_hammer'] = '錘子',
  ['weapon_hatchet'] = '斧頭',
  ['weapon_knife'] = '刀',
  ['weapon_knuckle'] = '指虎',
  ['weapon_machete'] = '開山刀',
  ['weapon_nightstick'] = '警棍',
  ['weapon_wrench'] = '扳手',
  ['weapon_poolcue'] = '桌球桿',
  ['weapon_stone_hatchet'] = '石斧',
  ['weapon_switchblade'] = '蝴蝶刀',

  -- Handguns
  ['weapon_appistol'] = '穿甲手槍',
  ['weapon_ceramicpistol'] = '陶瓷手槍',
  ['weapon_combatpistol'] = '戰鬥手槍',
  ['weapon_doubleaction'] = '雙動左輪手槍',
  ['weapon_navyrevolver'] = '海軍左輪手槍',
  ['weapon_flaregun'] = '信號槍',
  ['weapon_gadgetpistol'] = 'Gadget Pistol',
  ['weapon_heavypistol'] = '重型手槍',
  ['weapon_revolver'] = '重左輪手槍',
  ['weapon_revolver_mk2'] = '重左輪手槍 MK2',
  ['weapon_marksmanpistol'] = '神射手槍',
  ['weapon_pistol'] = '手槍',
  ['weapon_pistol_mk2'] = '手槍 MK2',
  ['weapon_pistol50'] = '.50口徑手槍',
  ['weapon_snspistol'] = '劣質手槍',
  ['weapon_snspistol_mk2'] = '劣質手槍 MK2',
  ['weapon_stungun'] = '電擊槍',
  ['weapon_raypistol'] = 'Up-N-Atomizer',
  ['weapon_vintagepistol'] = '老式手槍',

  -- Shotguns
  ['weapon_assaultshotgun'] = '突擊霰彈槍',
  ['weapon_autoshotgun'] = '半自動霰彈槍',
  ['weapon_bullpupshotgun'] = '泵動式霰彈槍',
  ['weapon_combatshotgun'] = '戰鬥霰彈槍',
  ['weapon_dbshotgun'] = '雙管霰彈槍',
  ['weapon_heavyshotgun'] = '重型霰彈槍',
  ['weapon_musket'] = '老式火槍',
  ['weapon_pumpshotgun'] = '霰彈槍',
  ['weapon_pumpshotgun_mk2'] = '霰彈槍 MK2',
  ['weapon_sawnoffshotgun'] = '削短型霰彈槍',

  -- SMG & LMG
  ['weapon_assaultsmg'] = '突擊衝鋒槍',
  ['weapon_combatmg'] = '戰鬥機槍',
  ['weapon_combatmg_mk2'] = '戰鬥機槍 MK2',
  ['weapon_combatpdw'] = '戰鬥自衛衝鋒槍',
  ['weapon_gusenberg'] = '古森柏衝鋒槍',
  ['weapon_machinepistol'] = '衝鋒手槍',
  ['weapon_mg'] = '機槍',
  ['weapon_microsmg'] = '烏茲衝鋒槍',
  ['weapon_minismg'] = '迷你衝鋒槍',
  ['weapon_smg'] = '衝鋒槍',
  ['weapon_smg_mk2'] = '衝鋒槍 MK2',
  ['weapon_raycarbine'] = 'Unholy Hellbringer',

  -- Rifles
  ['weapon_advancedrifle'] = '精準步槍',
  ['weapon_assaultrifle'] = '突擊步槍',
  ['weapon_assaultrifle_mk2'] = '突擊步槍 MK2',
  ['weapon_bullpuprifle'] = 'AUG突擊步槍',
  ['weapon_bullpuprifle_mk2'] = 'AUG突擊步槍 MK2',
  ['weapon_carbinerifle'] = '卡賓槍步槍',
  ['weapon_carbinerifle_mk2'] = '卡賓槍步槍 MK2',
  ['weapon_compactrifle'] = '半自動步槍',
  ['weapon_militaryrifle'] = '軍用步槍',
  ['weapon_specialcarbine'] = '特製卡賓槍',
  ['weapon_specialcarbine_mk2'] = '特製卡賓槍 MK2',

  -- Sniper
  ['weapon_heavysniper'] = '重型狙擊槍',
  ['weapon_heavysniper_mk2'] = '重型狙擊槍 MK2',
  ['weapon_marksmanrifle'] = '精確射手步槍',
  ['weapon_marksmanrifle_mk2'] = '精確射手步槍 MK2',
  ['weapon_sniperrifle'] = '狙擊步槍',

  -- Heavy / Launchers
  ['weapon_compactlauncher'] = '精簡榴彈發射器',
  ['weapon_firework'] = '煙火發射器',
  ['weapon_grenadelauncher'] = '榴彈砲',
  ['weapon_hominglauncher'] = '火箭彈發射器',
  ['weapon_minigun'] = '火神機槍',
  ['weapon_railgun'] = '電磁軌彈炮',
  ['weapon_rpg'] = '火箭炮',
  ['weapon_rayminigun'] = '寡婦製造者',

  -- Thrown
  ['weapon_ball'] = '棒球',
  ['weapon_bzgas'] = '催淚瓦斯',
  ['weapon_flare'] = '信號棒',
  ['weapon_grenade'] = '手榴彈',
  ['weapon_petrolcan'] = '汽油桶',
  ['weapon_hazardcan'] = '危險塑料汽油桶',
  ['weapon_molotov'] = '汽油彈',
  ['weapon_proxmine'] = '感應地雷',
  ['weapon_pipebomb'] = '土製炸彈',
  ['weapon_snowball'] = '雪球',
  ['weapon_stickybomb'] = '黏彈',
  ['weapon_smokegrenade'] = '煙霧彈',

  -- Special
  ['weapon_fireextinguisher'] = '滅火器',
  ['weapon_digiscanner'] = '數碼掃描儀',
  ['weapon_garbagebag'] = '垃圾袋',
  ['weapon_handcuffs'] = '手銬',
  ['gadget_nightvision'] = '夜視鏡',
  ['gadget_parachute'] = '降落傘',

  -- Weapon Components
  ['component_knuckle_base'] = '原裝',
  ['component_knuckle_pimp'] = 'the Pimp',
  ['component_knuckle_ballas'] = 'the Ballas',
  ['component_knuckle_dollar'] = 'the Hustler',
  ['component_knuckle_diamond'] = 'the Rock',
  ['component_knuckle_hate'] = 'the Hater',
  ['component_knuckle_love'] = 'the Lover',
  ['component_knuckle_player'] = 'the Player',
  ['component_knuckle_king'] = 'the King',
  ['component_knuckle_vagos'] = 'the Vagos',

  ['component_luxary_finish'] = '豪華武器套件',

  ['component_handle_default'] = 'default Handle',
  ['component_handle_vip'] = 'vIP Handle',
  ['component_handle_bodyguard'] = 'bodyguard Handle',

  ['component_vip_finish'] = 'vIP Finish',
  ['component_bodyguard_finish'] = 'bodyguard Finish',

  ['component_camo_finish'] = '迷彩武器套件',
  ['component_camo_finish2'] = '筆觸武器套件',
  ['component_camo_finish3'] = '木質武器套件',
  ['component_camo_finish4'] = '骷髏武器套件',
  ['component_camo_finish5'] = '塞桑塔武器套件',
  ['component_camo_finish6'] = '珀爾修斯武器套件',
  ['component_camo_finish7'] = '豹子武器套件',
  ['component_camo_finish8'] = '斑馬武器套件',
  ['component_camo_finish9'] = '幾何武器套件',
  ['component_camo_finish10'] = '動臂武器套件',
  ['component_camo_finish11'] = '愛國者武器套件',

  ['component_camo_slide_finish'] = '迷彩滑動武器套件',
  ['component_camo_slide_finish2'] = '筆觸滑動武器套件',
  ['component_camo_slide_finish3'] = '木質滑動武器套件',
  ['component_camo_slide_finish4'] = '骷髏滑動武器套件',
  ['component_camo_slide_finish5'] = '塞桑塔滑動武器套件',
  ['component_camo_slide_finish6'] = '珀爾修斯滑動武器套件',
  ['component_camo_slide_finish7'] = '豹子滑動武器套件',
  ['component_camo_slide_finish8'] = '斑馬滑動武器套件',
  ['component_camo_slide_finish9'] = '幾何滑動武器套件',
  ['component_camo_slide_finish10'] = '動臂滑動武器套件',
  ['component_camo_slide_finish11'] = '愛國者滑動武器套件',

  ['component_clip_default'] = '默認彈夾',
  ['component_clip_extended'] = '延伸彈夾',
  ['component_clip_drum'] = '彈鼓式彈匣',
  ['component_clip_box'] = '盒式彈匣',

  ['component_scope_holo'] = '全息瞄準鏡',
  ['component_scope_small'] = '小型瞄準鏡',
  ['component_scope_medium'] = '中型瞄準鏡',
  ['component_scope_large'] = '大型瞄準鏡',
  ['component_scope'] = '瞄準鏡',
  ['component_scope_advanced'] = '進階瞄準鏡',
  ['component_ironsights'] = '鐵瞄',

  ['component_suppressor'] = '抑制器',
  ['component_compensator'] = '補償器',

  ['component_muzzle_flat'] = '扁平槍嘴',
  ['component_muzzle_tactical'] = '戰術槍嘴',
  ['component_muzzle_fat'] = '胖端槍口制動器',
  ['component_muzzle_precision'] = '精密槍口制動器',
  ['component_muzzle_heavy'] = '重型槍口制動器',
  ['component_muzzle_slanted'] = '傾斜槍口制動器',
  ['component_muzzle_split'] = '分體式槍口制動器',
  ['component_muzzle_squared'] = '方形槍口制動器',

  ['component_flashlight'] = '手電筒',
  ['component_grip'] = '握把',

  ['component_barrel_default'] = '標準槍管',
  ['component_barrel_heavy'] = '重型槍管',

  ['component_ammo_tracer'] = 'tracer Ammo',
  ['component_ammo_incendiary'] = 'incendiary Ammo',
  ['component_ammo_hollowpoint'] = 'hollowpoint Ammo',
  ['component_ammo_fmj'] = 'fMJ Ammo',
  ['component_ammo_armor'] = 'armor Piercing Ammo',
  ['component_ammo_explosive'] = 'armor Piercing Incendiary Ammo',

  ['component_shells_default'] = 'default Shells',
  ['component_shells_incendiary'] = 'dragons Breath Shells',
  ['component_shells_armor'] = 'steel Buckshot Shells',
  ['component_shells_hollowpoint'] = 'flechette Shells',
  ['component_shells_explosive'] = 'explosive Slug Shells',

  -- Weapon Ammo
  ['ammo_rounds'] = '發(子彈)',
  ['ammo_shells'] = '發(子彈)',
  ['ammo_charge'] = '噴',
  ['ammo_petrol'] = '加崙(燃料)',
  ['ammo_firework'] = '發(煙火子彈)',
  ['ammo_rockets'] = '枚(火箭彈)',
  ['ammo_grenadelauncher'] = '發(榴彈)',
  ['ammo_grenade'] = '枚(手榴彈)',
  ['ammo_stickybomb'] = '枚(炸彈)',
  ['ammo_pipebomb'] = '枚(炸彈)',
  ['ammo_smokebomb'] = '枚(炸彈)',
  ['ammo_molotov'] = '瓶(汽油瓶)',
  ['ammo_proxmine'] = '個(地雷)',
  ['ammo_bzgas'] = '罐',
  ['ammo_ball'] = '顆(球)',
  ['ammo_snowball'] = '顆(雪球)',
  ['ammo_flare'] = '根(信號棒)',
  ['ammo_flaregun'] = '發(信號彈)',

  -- Weapon Tints
  ['tint_default'] = '默認色調',
  ['tint_green'] = '綠色調',
  ['tint_gold'] = '金色調',
  ['tint_pink'] = '粉色調',
  ['tint_army'] = '軍用色調',
  ['tint_lspd'] = '洛聖都警察局色調',
  ['tint_orange'] = '橘色調',
  ['tint_platinum'] = '柏金色調',
}
