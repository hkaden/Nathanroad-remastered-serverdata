/* 
*Author: Uyuyorum
*Description: Uyuyorum Loading Screen
*Version: 1.0
*Github: https://github.com/alp1x
*Discord: https://discord.gg/cf6wkBFeYV
*/

window.addEventListener('DOMContentLoaded', () => {
    if(window.nuiHandoverData.umloginscreen == "steam"){
        let getJson = JSON.parse(window.nuiHandoverData.json).response.players[0];
        $(".steamid").html(getJson.personaname);
        $(".steamimg").attr("src",getJson.avatarfull);
    }
});
// UM-General Settings //
  $('#stage').hide()
  $('#snow').show()
  var pointer = $('#cursor');
  $(document).on('mousemove', function (event) {
    pointer.css({
      top: event.pageY + 'px',
      left: event.pageX + 'px'
    });
  });
// $.get(UMLoadingScreen.GithubRawUrl, function (data){$(".updatesinfo p").html(data);})
// $.getJSON("https://api.ipify.org/?format=json", function(e) {$(".characterinfo p.userip").html('IP Address: '+e.ip);});
   // $('body').css("background-image", "url(assets/img/bg/"+UMLoadingScreen.BackgroundImage+")");
    $(".background").css('background',UMLoadingScreen.TemplateColorHex);
    $(".logo img").attr("src","assets/img/"+UMLoadingScreen.Logo);

    // UM-Lang Settings //
    // $("span.welcometext").html(UMLoadingScreen.Text1);
    // $("span.newuptext").html(UMLoadingScreen.Text2);
    $("p.updatedata").html(UMLoadingScreen.Text4);
    $("h2.servernameh2").html(UMLoadingScreen.ServerName);
    $("p.copyright").html(UMLoadingScreen.Text3);

    // UM-Icon Settings //
    var myAudio = document.getElementById("music");    
    myAudio.volume = UMLoadingScreen.MusicVolume;
    myAudio.play();
    var play = true
    var logo = false
    $(".fa-volume-up").click(function(){
        if (play) {
            $("#volumeup i").attr("class","fas fa-volume-mute background");
            myAudio.pause();
            play = false;
        } else {
            $("#volumeup i").attr("class","fas fa-volume-up background");
            myAudio.play();
            play = true;
        }
    });
    $(".fa-gamepad").click(function(){
        $("#stage").toggle("slow");
        if (logo == false) {
            $('.logo').hide();
            logo = true
        } else {
            $('.logo').show();
            logo = false
        }
    });
    $(".fa-snowflake").click(function(){
        $("#snow").toggle();
    });

    $(document).ready(function() {
        var myAudio = document.getElementById("music");    
        myAudio.play();
    });
