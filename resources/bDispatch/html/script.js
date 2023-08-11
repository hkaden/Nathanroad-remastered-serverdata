let notifID = 0
let menuOpened = false
let ClickedCase = 0
let jobsColor = {
  ["police"]: "blue",
  ["ambulance"]: "red"
}
let myCode = 0

var audio = new Audio('sounds/notif.mp3');
var sos = new Audio('sounds/sos.mp3')
audio.volume = 0.75;
sos.volume = 0.8;

window.addEventListener('message', function (event) {
    let data = event.data

    if (data.action == "open") {
      $(".container").show()
      menuOpened = true

      $(".topMenu").find(".person-code").html(data.myCode)
      $(".topMenu").find("#myName").html(data.myName)
      $(".topMenu").find(".person-code").addClass(jobsColor[data.job])
      myCode = data.myCode
    }

    if (data.action == "close") {
      $(".container").hide()
      menuOpened = false
    }

    if (data.action == "addCase") {
      if (!menuOpened && data.allowed) {
        $(".pozivNotifikacija").append(`
          <div class = "jedan-poziv" id = "Notifcase_${data.caseID}">
            <div class = "kod">${data.casecode}</div>
            <div class ="naslov-slucaja">${data.casetitle}</div>
            <div class ="naslov-opis">${data.casedesc}</div>
          </div>
        `)

        $(`#Notifcase_${data.caseID}`).show("slide", { direction: "right" }, 700).delay(5000).hide("slide", { direction: "right" }, 1000)
      }

      $(".lista-poziva").prepend(`
        <div class = "jedan-poziv" id = "FullCase_${data.caseID}" >
          <div class = "right-klik" caseid = "${data.caseID}"></div>
          <div class = "time">${moment.unix(data.time)}</div>
          <div class = "kod">${data.casecode}</div>
          <div class ="naslov-slucaja">${data.casetitle}</div>
          <div class ="naslov-opis">${data.casedesc}</div>
          <div class ="broj-slucaj">${data.casenumber ? data.casenumber : "N/N"}</div>
          <div class = "dugme-kolege-slucaj"><div class = "kolege-button">參與案件 (0)</div></div>

          <div class = "naslucaj-kolege"></div>
        </div>
      `)

      if (data.casecode == "11-99") {
        sos.pause();
        sos.currentTime = 0;
        sos.play();
      } else if (data.casecode != "10-99") {
        audio.pause();
        audio.currentTime = 0;
        audio.play();
      }
    }

    if (data.action == "addtoCase") {
      if ($(`#FullCase_${data.caseID}`).find('.naslucaj-kolege').length > 0) {
        $(`#FullCase_${data.caseID}`).find('.naslucaj-kolege').append(`
          <div class = "jedanKolega-slucaj" id = "kolega_${data.personcode}">
            <div class = "person-code ${jobsColor[data.job]}">${data.personcode}</div><div class ="person-name">${data.personame}</div>
          </div>
        `);

        let caseCount = $(`#FullCase_${data.caseID}`).find('.naslucaj-kolege').find('.jedanKolega-slucaj').length
        $(`#FullCase_${data.caseID}`).find('.kolege-button').html(`參與案件 (${caseCount})`)
      }
    }

    if (data.action == "removeFromCase") {
      $(`#FullCase_${data.caseID}`).find('.naslucaj-kolege').find(`#kolega_${data.personcode}`).remove()

      let caseCount = $(`#FullCase_${data.caseID}`).find('.naslucaj-kolege').find('.jedanKolega-slucaj').length
      $(`#FullCase_${data.caseID}`).find('.kolege-button').html(`參與案件 (${caseCount})`)
    }

    if (data.action == "addToMembers") {
      if (data.job) {
        if ( document.getElementById(`member_${data.servicecode}`) ) {
          console.log("vec ima kod")
          $(`#member_${data.servicecode}`).html(`<div class = "person-code ${jobsColor[data.job]}">${data.servicecode}</div><div class ="person-name">${data.name}</div>`)
        } else {
          $(`.listakolega-${data.job}`).append(`
            <div class = "jedanKolega-slucaj" id = "member_${data.servicecode}">
              <div class = "person-code ${jobsColor[data.job]}">${data.servicecode}</div><div class ="person-name">${data.name}</div>
            </div>
          `)
        }
      }
    }

    if (data.action == "removeFromMembers") {
      if (data.job) {
          $(`.listakolega-${data.job}`).find(`#member_${data.servicecode}`).remove()
      }
    }
});


$("body").on("click", ".kolege-button", function(){
  $(this).parent().next('.naslucaj-kolege').toggle();
})


$(document).click(function(event) {
  if ( $(event.target).attr("id") != "contextMenu" ) {
    $("#contextMenu").hide();
  }
});

$('body').mousedown(function(event) {
    if (event.which == 3) {
      let targClasas = $(event.target).attr("class")

      if (targClasas == "right-klik" ) {

        ClickedCase = $(event.target).attr("caseid")
        console.log(myCode)
        if ($(`#FullCase_${ClickedCase}`).find('.naslucaj-kolege').find(`#kolega_${myCode}`).length) {
          $("#contextMenu").html(`
            <div class = "button-context" id = "proslijedi-policija">轉交給警察</div>
            <div class = "button-context" id = "proslijedi-bolnica">轉交給醫護人員</div>
            <div class = "button-context" id = "napustislucaj">退出案件</div>
          `)
        } else {
          $("#contextMenu").html(`
            <div class = "button-context" id = "proslijedi-policija">轉交給警察</div>
            <div class = "button-context" id = "proslijedi-bolnica">轉交給醫護人員</div>
            <div class = "button-context" id = "uzmislucaj">參與案件</div>
          `)
        }

        $("#contextMenu").css({
             display: "block",
             left: event.pageX,
             top: event.pageY
        });

      } else if ( targClasas == "listakolega-naslov") {

        if ($(event.target).attr("id") == "podrska-policija") {
          $("#contextMenu").html(`
            <div class = "button-context" id = "podrska-policija">警察支援</div>
          `)

        } else if ($(event.target).attr("id") == "podrska-bolnica") {
          $("#contextMenu").html(`
            <div class = "button-context" id = "podrska-bolnica">醫護人員支援</div>
          `)
        }

        $("#contextMenu").css({
             display: "block",
             left: event.pageX,
             top: event.pageY
        });

      } else {
        $("#contextMenu").hide();
      }
    }
});

$("#contextMenu").on("click", "#uzmislucaj", function(){
  $.post(`https://${GetParentResourceName()}/addtoCase`, JSON.stringify({
    caseID: ClickedCase
  }));
})

$("#contextMenu").on("click", "#napustislucaj", function(){
  $.post(`https://${GetParentResourceName()}/removeFromCase`, JSON.stringify({
    caseID: ClickedCase
  }));
})

document.addEventListener("keydown", function(ev) {
    if( ev.key == "Escape" ){
      $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
      $("#contextMenu").hide();
    }
});

$("#button-sakrijGPS").on("click", function(){
  $.post(`https://${GetParentResourceName()}/toggleBlips`, JSON.stringify({}));
})

$("#button-notifSound").on("click", function(){
  $.post(`https://${GetParentResourceName()}/soundNotif`, JSON.stringify({}));
})

$("#button-notifDisplay").on("click", function(){
  $.post(`https://${GetParentResourceName()}/notifDisplay`, JSON.stringify({}));
})

$("#button-gpsDisplay").on("click", function(){
  $.post(`https://${GetParentResourceName()}/gpsDisplay`, JSON.stringify({}));
})

$("#contextMenu").on("click", "#proslijedi-bolnica", function(){
  $.post(`https://${GetParentResourceName()}/transferAmbulance`, JSON.stringify({
    caseID: ClickedCase
  }));
})

$("#contextMenu").on("click", "#proslijedi-policija", function(){
  $.post(`https://${GetParentResourceName()}/transferPolice`, JSON.stringify({
    caseID: ClickedCase
  }));
})

$("#contextMenu").on("click", "#podrska-bolnica", function(){
  console.log("bolnica klik")
  $.post(`https://${GetParentResourceName()}/requestHelp`, JSON.stringify({
    job: "ambulance",
    myCode: myCode
  }));
})

$("#contextMenu").on("click", "#podrska-policija", function(){
  console.log("police klik")
  $.post(`https://${GetParentResourceName()}/requestHelp`, JSON.stringify({
    job: "police",
    myCode: myCode
  }));
})
