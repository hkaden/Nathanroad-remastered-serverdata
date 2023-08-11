$.each(Profiles,function(k,v){
    $('#profiles').prepend(
        `<option value="${k}">${v().label}</option>`
    )
})

var settings = Profiles.default()

OnUpdate = function(){
    $('.main').css({
        width:`${settings.offset}vh`,
        height:`${settings.offset}vh`,
    })
    $('.panel-preview').css({
        width:`${settings.offset}vh`,
        height:`${settings.offset}vh`,
    })
    $('.top').css('width',`${settings.thickness}vh`)
    $('.bottom').css('width',`${settings.thickness}vh`)
    $('.left').css('height',`${settings.thickness}vh`)
    $('.right').css('height',`${settings.thickness}vh`)
    $('.top').css('height',`${settings.length}vh`)
    $('.bottom').css('height',`${settings.length}vh`)
    $('.left').css('width',`${settings.length}vh`)
    $('.right').css('width',`${settings.length}vh`)
    $('.top').css('background-color',`${settings.color}`)
    $('.bottom').css('background-color',`${settings.color}`)
    $('.left').css('background-color',`${settings.color}`)
    $('.right').css('background-color',`${settings.color}`)
    $('.dot').css('background-color',`${settings.color}`)
    $('.dot').css({
        width:`${settings.dot}vh`,
        height:`${settings.dot}vh`,
    })
    if(settings.buttons.dot){
        $('#dot-switch').children().find('div').css('opacity','1')
        $('#dot-switch').find('.on').css('opacity','0.2')
        $('.dot').show()
    }else{
        $('#dot-switch').children().find('div').css('opacity','1')
        $('#dot-switch').find('.off').css('opacity','0.2')
        $('.dot').hide()
    }
    if(settings.buttons.lines){
        $('#lines-switch').children().find('div').css('opacity','1')
        $('#lines-switch').find('.on').css('opacity','0.2')
        $('.top').show()
        $('.bottom').show()
        $('.left').show()
        $('.right').show()
    }else{
        $('#lines-switch').children().find('div').css('opacity','1')
        $('#lines-switch').find('.off').css('opacity','0.2')
        $('.top').hide()
        $('.bottom').hide()
        $('.left').hide()
        $('.right').hide()
    }
    $('#offset').parent().children().first().html(`偏移 (${settings.offset})`)
    $('#thickness').parent().children().first().html(`線厚度 (${settings.thickness*10})`)
    $('#length').parent().children().first().html(`長度 (${settings.length*10})`)
    $('#dot-radius').parent().children().first().html(`紅點 (${settings.dot*10})`)
    $('#color').parent().children().first().html(`顏色 (${settings.color})`)
}

$('#offset').bind('input',function(){
    settings.offset = $(this).val()
    OnUpdate()
})

$('#thickness').bind('input',function(){
    settings.thickness = $(this).val()/10
    OnUpdate()
})

$('#length').bind('input',function(){
    settings.length = $(this).val()/10
    OnUpdate()
})

$('#dot-radius').bind('input',function(){
    settings.dot = $(this).val()/10
    OnUpdate()
})

$('#color').bind('input',function(){
    settings.color = $(this).val()
    OnUpdate()
})

$('select').bind('input',function(){
    var val = $(this).val()
    if (Profiles[val]()){
        settings = Profiles[val]()
        OnUpdate()
        $('#offset').val(settings.offset)
        $('#thickness').val(settings.thickness*10)
        $('#length').val(settings.length*10)
        $('#dot-radius').val(settings.dot*10)
        $('#color').val(settings.color)
    }
})

$('.on').click(function(){
    switch($(this).parent().parent().attr('id')){
        case 'dot-switch':
            settings.buttons.dot = true
            OnUpdate()
            break;
        case 'lines-switch':
            settings.buttons.lines = true 
            OnUpdate()
            break;
    }
})

$('.off').click(function(){
    switch($(this).parent().parent().attr('id')){
        case 'dot-switch':
            settings.buttons.dot = false
            OnUpdate()
            break;
        case 'lines-switch':
            settings.buttons.lines = false 
            OnUpdate()
            break;
    }
})

$('.save-button').click(function(){
    $.post('https://'+GetParentResourceName()+'/UpdateSettings',JSON.stringify({
        settings:settings
    }))
})

addEventListener("message",function(event){
    var data = event.data
    if (data.action == "OpenPanel"){
        $('.panel').fadeIn()
        $('#offset').val(settings.offset)
        $('#thickness').val(settings.thickness*10)
        $('#length').val(settings.length*10)
        $('#dot-radius').val(settings.dot*10)
        $('#color').val(settings.color)
    }
    if(data.action == "LoadSettings"){
        settings = data.settings
        OnUpdate()
    }
    data.action == "ShowCrosshair" && $('.main').show() || data.action == "HideCrosshair" &&  $('.main').hide()
})

$(document).on('keydown', function(event) {
    if(event.keyCode == 27){
        $('.panel').fadeOut()
        $.post('https://'+GetParentResourceName()+'/CloseNUI')
    }
})