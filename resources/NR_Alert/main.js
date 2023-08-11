var snd = new Audio("alert.mp3");
var eventmp3 = new Audio("event01.mp3");

function alert(volume) {
    snd.volume = volume;
    snd.play();
    setTimeout(function () {
        snd.pause();
        snd.currentTime = 0;
        document.body.style.display = "none";
    }, 22 * 1000);
}

function Eventalert(volume) {
    eventmp3.volume = volume;
    eventmp3.play();
    setTimeout(function () {
        eventmp3.pause();
        eventmp3.currentTime = 0;
        document.body.style.display = "none";
    }, 77 * 1000);
}

function hide() {
    var x = document.getElementById("eas");
    if (document.body.style.display === "none") {
        document.body.style.display = "block";
    } else {
        document.body.style.display = "none";
    }
}

function addCommas(nStr) {
    nStr += "";
    var x = nStr.split(".");
    var x1 = x[0];
    var x2 = x.length > 1 ? "." + x[1] : "";
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(
            rgx,
            "$1" + '<span style="margin-left: 3px; margin-right: 3px;"/>' + "$2"
        );
    }
    return x1 + x2;
}

$(function () {
    window.addEventListener("message", function (event) {
        if (event.data.type == "alert") {
            $(".eas").css({
                borderTop: "4px solid #fbc308",
                borderBottom: "4px solid #fbc308",
                borderLeft: "4px solid #fbc308",
                borderRight: "4px solid #fbc308",
                borderStyle: "dashed",
                background: "rgba(0, 0, 0, 0.7)",
            });
            $(".eas_alerter").html(
                "<p>由彌敦道" +
                    event.data.issuer +
                    '發出的公告</p> </marquee><marquee behavior="scroll" direction="left" scrollamount="16" style="font-size:25px"><p>' +
                    event.data.message +
                    "</p></marquee>"
            );
            document.body.style.display = event.data.enable ? "block" : "none";
            alert(event.data.volume);
        } else if (event.data.type == "event01") {
            $(".eas").css({
                borderTop: "4px solid red",
                borderBottom: "4px solid red",
                borderLeft: "4px solid red",
                borderRight: "4px solid red",
                background: "rgba(0, 0, 0, 1.0)",
            });
            $(".eas_alerter").html(
                '<p>由彌敦道政府發出的公告</p> </marquee><marquee behavior="scroll" direction="left" scrollamount="16" style="font-size:25px"><p style="font-size:35px">' +
                    event.data.message +
                    "</p></marquee>"
            );
            document.body.style.display = event.data.enable ? "block" : "none";
            Eventalert(event.data.volume);
        } else if (event.data.type == "moon") {
            $(".eas_alerter").html(
                '</marquee><marquee behavior="scroll" direction="left" scrollamount="16" style="font-size:25px"><p style="font-size:35px"> <img src="mooncake.png" alt="" width="2440" height="949">' +
                    "</p></marquee>"
            );
            document.body.style.display = event.data.enable ? "block" : "none";
            setTimeout(function () {
                document.body.style.display = "none";
            }, 23 * 1000);
        }
    });
});
