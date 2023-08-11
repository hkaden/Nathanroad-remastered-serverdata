var timeout;
var keybindActive = null;
var closeonclick = true;
var keybind = false;

function closeMenu() {
    $.post("https://NR_Keybinds/close", JSON.stringify({}));

    if (keybind) {
        $("div").each(function () {
            if ($(this).attr("id") == "keybind-select") {
                var key = $(this).find("#u1557").text();
                var command = $(this).find("#u1558 :selected").val();

                if (key != "-" && command != "none") {
                    $.post(
                        "https://NR_Keybinds/registerKeybind",
                        JSON.stringify({ command: command, key: key })
                    );
                }
            }
        });

        $.post("https://NR_Keybinds/updateKeybinds", JSON.stringify({}));
    }

    $("#main_container").fadeOut(400);
    timeout = setTimeout(function () {
        $("#main_container").html("");
        $("#main_container").fadeIn();
    }, 400);
}

function keybindFocus(t) {
    playClickSound();
    if (keybindActive == t) {
        $(t).css("scale", "1.00");
        keybindActive = null;
    } else {
        $(document).find(".keybind").css("scale", "1.00");
        $(t).css("scale", "1.05");
        keybindActive = t;
    }
}

$(window).on("keydown", function (e) {
    if (keybindActive != null) {
        var code = e.keyCode ? e.keyCode : e.which;
        $(keybindActive).text(e.key.toUpperCase());
        keybindActive = null;
        $(document).find(".keybind").css("scale", "1.00");
    }
});

function OpenKeybinds(options, current) {
    var count = 0;
    var base =
        '<div class="clearfix" id="page"><!-- group -->' +
        '<div class="slide-top" id="container">' +
        '   <div class="clearfix grpelem" id="u1592-4"><!-- content -->' +
        "    <p>KEYBINDS</p>" +
        "   </div>" +
        '   <div class="clearfix grpelem" id="u1545"><!-- group -->';

    for (const [key, value] of Object.entries(current)) {
        base =
            base +
            '<div id="keybind-select">' +
            '     <div class="gradient colelem keybind " onclick="keybindFocus(this)" id="u1557" >' +
            key +
            "</div>" +
            '<select  id="u1558">' +
            '    <option value="none">-</option>';

        for (g = 0; g < Object.keys(options).length; g++) {
            if (options[g].command == value) {
                base =
                    base +
                    '    <option class="select-items" selected="selected" value="' +
                    options[g].command +
                    '">' +
                    options[g].label +
                    "</option>";
            } else {
                base =
                    base +
                    '    <option class="select-items" value="' +
                    options[g].command +
                    '">' +
                    options[g].label +
                    "</option>";
            }
        }

        base = base + "  </select>" + "</div>";

        count = count + 1;
    }

    for (a = 0; a < Object.keys(options).length - count; a++) {
        base =
            base +
            '<div id="keybind-select">' +
            '     <div class="gradient colelem keybind " onclick="keybindFocus(this)" id="u1557" >-</div>' +
            '<select  id="u1558">' +
            '    <option value="none">-</option>';

        for (b = 0; b < Object.keys(options).length; b++) {
            base =
                base +
                '    <option value="' +
                options[b].command +
                '">' +
                options[b].label +
                "</option>";
        }

        base = base + "  </select>" + "</div>";
    }

    base =
        base +
        "    </div>" +
        "   </div>" +
        "</div>" +
        '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="688" data-content-below-spacer="1078"></div>' +
        "  </div>";

    $("#main_container").append(base);

    $(".box").hover(function () {
        playClickSound();
    });
}

function clickBox(t) {
    var trigger = t.dataset.trigger;

    if (closeonclick) {
        closeMenu();
    }

    $.post("https://NR_Keybinds/" + trigger, JSON.stringify({}));
}

function OpenMenu(label, boxes, fill, job) {
    var filled = 0;
    var base =
        '<div class="clearfix" id="page"><!-- group -->' +
        '<div class="slide-top" id="container">' +
        '   <div class="clearfix grpelem" id="u1592-4"><!-- content -->' +
        "    <p>" +
        label +
        "</p>" +
        "   </div>" +
        '   <div class="clearfix grpelem" id="u1541"><!-- group -->';
    for (i = 0; i < Object.keys(boxes).length; i++) {
        if (
            boxes[i].jobWhitelist.includes(job) ||
            Object.keys(boxes[i].jobWhitelist).length == 0
        ) {
            base =
                base +
                '     <div class="gradient colelem box " id="u1556" data-trigger="' +
                boxes[i].trigger +
                '" onclick="clickBox(this)"><i class="' +
                boxes[i].icon +
                '"></i><p class="label">' +
                boxes[i].label +
                "</p></div>";

            filled = filled + 1;
        }
    }
    if (fill) {
        for (i = 0; i < 12 - filled; i++) {
            base =
                base +
                '     <div class="gradient colelem box" id="u1556"></div>';
        }
    }

    base =
        base +
        "    </div>" +
        "   </div>" +
        "</div>" +
        '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="688" data-content-below-spacer="1078"></div>' +
        "  </div>";

    $("#main_container").append(base);

    $(".box").mouseover(function () {
        playClickSound();
    });
}

$(document).keyup(function (e) {
    if (e.keyCode === 27) {
        closeMenu();
    }
});

function playClickSound() {
    var audio = document.getElementById("clickaudio");
    audio.volume = 0.05;
    audio.play();
}

window.addEventListener("message", function (event) {
    var edata = event.data;

    if (edata.type == "keybinds") {
        clearTimeout(timeout);
        $("#main_container").html("");
        $("#main_container").stop().fadeIn();

        keybind = true;

        OpenKeybinds(edata.keybinds, edata.current);
    }
    if (edata.type == "menu") {
        clearTimeout(timeout);
        $("#main_container").html("");
        $("#main_container").stop().fadeIn();

        closeonclick = edata.close;
        keybind = false;

        OpenMenu(edata.label, edata.boxes, edata.fill, edata.job);
    }
});