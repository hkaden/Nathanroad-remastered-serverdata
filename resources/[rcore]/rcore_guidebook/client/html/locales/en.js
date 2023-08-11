// Refactor info categories
const locales = {
    general: {
        guide_title: '遊戲指南',
        irreversible: '這個動作不可<b>復原</b>!',
        lost_pages: '在分類內的頁面全部都會<b>刪除</b>!',
        are_you_sure: '你確定嗎?',
    },
    category: {
        category: '分類',
        categories: '分類',
        category_empty: '沒有分類',
        category_editing: '編輯分類',
        category_creating: '建立分類',
    },
    page: {
        pages: '頁面',
        page_editing: '編輯頁面',
        page_creating: '建立頁面',
    },
    page_template: {
        not_found_page: `<h1> 糟糕了! 找不到頁面!</h1>`,
        admin_welcome: `<h1>Important person coming through!</h1>
        <p>
            Welcome to the <b>admin system</b> of this guidebook! <br>
            Don't forget your tools for the important admin work 🔨🔧
        </p>`,
    },
    inputs: {
        enabled: '啟用',
        disabled: '停用',
        label: '標籤',
        key: '關鍵字',
        order_number: '排序',
        expanded: '展開',
        content: '內容',
        save: '儲存',
        delete: '刪除',
        create: '建立',
        cancel: '取消',
        deleting: `正在刪除:`,
        can_navigate: '可以前往',
        blip_enabled: '標點啟用',
        blip_sprite: '標點圖案',
        blip_display_type: '標點顯示類型',
        blip_color: '標點顏色',
        blip_size: '標點大小',
        marker_enabled: '標記啟用',
        marker_size: '標記大小',
        marker_color: '標記顏色',
        marker_type: '標記類型',
        marker_draw_distance: '標記繪製距離',
        size: '大小',
        color: '顏色',
        start_date: '開始日期',
        end_date: '結束日期',
        draw_distance: '繪製距離',
        open_page: '開啟頁面',
        position: '位置',
        custom_content: '自訂內容',
        nav_btn: '導航按鈕',
    },
    exceptions: {
        cant_be_empty: `不能為空`,
        greater_equal_zero: '必須大於等於0',
        key_exists: '關鍵字已存在',
        not_a_number: '不是數字',
        success: '成功',
        error: '錯誤',
    },
    notification: {
        data_save_success: '資料儲存成功',
        data_save_error: '資料儲存失敗',
        data_delete_success: '資料刪除成功',
        data_delete_error: '資料刪除失敗',
        teleport_success: '傳送成功',
        teleport_error: '傳送失敗',
        link_copied: '連結已複製',
        key_copied: '關鍵字已複製',
        gps_set: 'GPS已設定',
        image_paste_error: "圖片無法貼上，請使用工具欄",
    },
    point: {
        point_help: 'Point help',
        points: 'Points',
        points_help: 'Create in-game markers or 3D texts with custom content or directly open help page',
        open_help: 'Open help',
        own_content: 'Own content',
        add_point: 'Add new point',
        add_point_help: 'Create new in-game point with draw type, distance, blip and more!',
        editing_point: 'Editing point',
        teleport: "You will be teleported into point location",
        teleportNow: 'Teleport',
    },
    placeholders: {
        category_label: 'Gangs...',
        category_key: 'gangs...',
        page_label: 'Getting a gun...',
        page_key: 'gangs-gun...',
        point_label: 'How to get a gun...',
        point_key: 'get_gun...',
        point_content: 'So you want to get a gun? First you have to...',
        image_url: 'Image URL',
        nav_btn_label: 'Navigate...',
    },
    tooltip: {
        resize: '☝️ Tip: You can right click image/video to show resizing tools!',
        arrow_inputs: '☝️ Tip: You can use <kbd>&larr;</kbd><kbd>&rarr;</kbd> to change value in range sliders with precision!',
        open_page: 'Select guide page to open on point interaction',
        order_number: 'Categories and pages are sorted in ascending order (smallest number first).',
        key: 'Unique key to use for reference, use the generated one, or type in yours.',
        new_line: 'You can use ~n~ as new line',
        enabled: 'If enabled, this category/page will appear in the guidebook. However if you disable it, this page/category becomes invisible in the guidebook and accessible only through help point or command to send help!',
        can_navigate: 'If enabled, you can use `/pointgps [pointKey]` to set waypoint to this point.',
    },
}