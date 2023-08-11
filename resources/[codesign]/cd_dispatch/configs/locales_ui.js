const locale = {
  cd_dispatch_small_title: "沒有派遣任務",
  cd_dispatch_small_previous: "上一個",
  cd_dispatch_small_next: "下一個",
  cd_dispatch_small_respond: "回應",
  cd_dispatch_small_mode: "按右鍵離開走動模式",

  cd_dispatch_main_show_refresh_bar: "顯示",
  cd_dispatch_main_hide_refresh_bar: "隱藏",
  cd_dispatch_main_refresh: "刷新標點",
  cd_dispatch_main_close_refresh_bar: "關閉",
  cd_dispatch_main_refresh_last: "上次刷新",

  cd_dispatch_main_units_responding: "個回應",

  cd_dispatch_unit_list: "人員列表",

  cd_dispatch_main_dropdown_respond: "回應任務通知",
  cd_dispatch_main_dropdown_remove_response: "移除回應任務通知",
  cd_dispatch_main_dropdown_remove_notification: "刪除任務通知",
  cd_dispatch_main_dropdown_remove_all: "刪除所有任務通知",
  cd_dispatch_main_dropdown_assign_all: "分配所有人至任務",

  cd_dispatch_main_modal_title: "選單設定",
  cd_dispatch_main_modal_autodel: "自動刪除",
  cd_dispatch_main_modal_autodel_desc:"自動刪除通知的時間 (以分鐘為單位 1-60)",
  cd_dispatch_main_modal_set_callsign:"更新行動呼號",
  cd_dispatch_main_modal_set_callsign_help:"讓所有職員看見你",
  cd_dispatch_main_modal_assigned_vehicle:"分配標記",
  cd_dispatch_main_modal_close: "關閉",
  cd_dispatch_main_modal_save: "儲存",
  cd_dispatch_main_modal_vehicle_foot:" 步走",
  cd_dispatch_main_modal_vehicle_car:" 車",
  cd_dispatch_main_modal_vehicle_motorcycle:" 電單車",
  cd_dispatch_main_modal_vehicle_helicopter:" 直升機",
  cd_dispatch_main_modal_vehicle_boat: " 船",
  cd_dispatch_main_modal_sound_control: "聲音控制",
  cd_dispatch_main_modal_mute_sounds: " 靜音",
  cd_dispatch_main_modal_mute_sounds_description: "這選項會將緊急按鈕靜音",
  cd_dispatch_main_modal_enable_dispatcher: "啟用派遣模式?",
  cd_dispatch_main_modal_toggle_button:"切換派遣模式",
  cd_dispatch_main_modal_dispatcher_status: "派遣模式現在已",
  cd_dispatch_main_modal_dispatcher_status_enabled: "開啟",
  cd_dispatch_main_modal_dispatcher_status_disabled: "關閉",

  cd_dispatch_unit_dropdown_gps: "設置GPS位置",
  cd_dispatch_unit_join_radio:"加入無線電頻道",
  cd_dispatch_unit_leave_radio:"離開無線電頻道",

  cd_dispatch_toggle_voice_on: "切換語音: 開",
  cd_dispatch_toggle_voice_off: "切換語音: 關",
  cd_dispatch_revert_map: "還原地圖",

  cd_dispatch_notification_panel: "任務通知板",

  cd_dispatch_settings_status: "狀態",
  cd_dispatch_settings_status_help: "選擇你現在的狀態.",

  cd_dispatch_units_notification: "沒有人回應",

  cd_dispatch_tamper_message: "你是否篡改了這些數值?",
  cd_dispatch_callsign_message: "行動戶號必須是16個字符以下",

};

let statusMessages = [
  {name:"可用", color:"#539D1B"}, // The status will default to the first one in the list
  {name:"不可用", color:"#F05B56"},
  {name:"處理中", color:"#E46211"},
  {name:"訓練中", color:"#009DE0"},
  {name:"隱身", color:"#2E570F"},
]

moment.locale("zh-hk"); // The locale of the time on top of the small UI

// Possible locales v
// en,af,ar-dz,ar-kw,ar-ly,ar-ma,ar-sa,ar-tn,ar,az,be,bg,bm,bn-bd,bn,bo,br,bs,ca,cs,cv,cy,da,de-at,de-ch,de,dv,el,en-au,en-ca,en-gb,en-ie,en-il,en-in,en-nz,en-sg,eo,es-do,es-mx,es-us,es,et,eu,fa,fi,fil,fo,fr-ca,fr-ch,fr,fy,ga,gd,gl,gom-deva,gom-latn,gu,he,hi,hr,hu,hy-am,id,is,it-ch,it,ja,jv,ka,kk,km,kn,ko,ku,ky,lb,lo,lt,lv,me,mi,mk,ml,mn,mr,ms-my,ms,mt,my,nb,ne,nl-be,nl,nn,oc-lnc,pa-in,pl,pt-br,pt,ro,ru,sd,se,si,sk,sl,sq,sr-cyrl,sr,ss,sv,sw,ta,te,tet,tg,th,tk,tl-ph,tlh,tr,tzl,tzm-latn,tzm,ug-cn,uk,ur,uz-latn,uz,vi,x-pseudo,yo,zh-cn,zh-hk,zh-mo,zh-tw
