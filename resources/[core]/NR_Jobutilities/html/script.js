var job = 'unemployed';
var grade = 3;


$(document).keyup(function (e) {
    if (e.keyCode === 27) {
        $.post('https://NR_Jobutilities/close', JSON.stringify({}));
        $("#main_container").fadeOut("slow", function () {
            $("#main_container").html("").fadeIn();
        });
    }

});

function playClickSound() {
    var audio = document.getElementById("audio");
    audio.volume = 0.1;
    audio.play();
}

function openBossMenu(job, label, employees, fund, canwithdraw, candeposit, canhire, canrank, canfire, ranks, canbonus) {
    currentRanks = ranks;
    currentBossMenuJob = job;

    var base = '<div class="clearfix" id="page"><!-- group -->' + '   <div class="clearfix grpelem slide-top" id="pu657"><!-- column -->';
    if (canhire) {
        base = base + '<div id="addemployee" onclick="openHire()" class="ripple"><i class="fas fa-plus" style="margin-top: 12px;"></i></div>';
    } else {
        base = base + '<div id="addemployee" style="opacity: 0.5;" class="ripple"><i class="fas fa-plus" style="margin-top: 12px;"></i></div>';
    } base = base + '   <div class="gradient rounded-corners grpelem" id="u654"><!-- simple frame --></div>' + '    <div class="colelem" id="u657"><!-- simple frame --></div>' + '    <div class="clearfix colelem" id="u660-4"><!-- content -->' + '     <p>' + label.toUpperCase() + '</p>' + '    </div>';

    base = base + '  ' + '    <div class="clearfix colelem" id="u688-4"><!-- content -->' + '     <p>僱員</p>' + '    </div>' + '    <div class="clearfix colelem" id="u682"><!-- column -->';

    for (i = 0; i < employees.length; i ++) {

        base = base + '     <div class="rounded-corners clearfix colelem" id="u745"><!-- group -->' + '      <div class="clearfix grpelem" id="pu746-4"><!-- column -->' + '       <div class="clearfix colelem" id="u746-4"><!-- content -->' + '        <p><span id="u746">' + employees[i].fullname + '</span></p>' + '       </div>' + '       <div class="clearfix colelem" id="u747-4"><!-- content -->' + '        <p>' + employees[i].grade_label + '</p>' + '       </div>' + '      </div>';
        if (canrank) {
            base = base + '      <div class="grpelem ripple" data-identifier="' + employees[i].identifier + '" onclick="openRanks(this)" id="u749"><i class="fas fa-layer-group " ></i></div>';
        }

        if (canfire) {
            base = base + '      <div class="grpelem ripple" data-identifier="' + employees[i].identifier + '" onclick="sureWindow(this)" id="u748"><i class="fas fa-times fa-lg " ></i></div>';
        }

        if (canbonus) {
            base = base + '      <div class="grpelem ripple" data-identifier="' + employees[i].identifier + '" onclick="openBonus(this)" id="u747"><i class="fas fa-hand-holding-usd " ></i></div>';
        }
        base = base + '     </div>';
    }

    base = base + '    </div>' + '   </div>' + '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="712" data-content-below-spacer="18"></div>' + '  </div>';

    $("#main_container").html(base);
}


function openHire() {
    playClickSound();
    var base = '<div id="input">' + '<div id="darken"><div>' + '<div id="inputfield" class="slide-top">' + '        <p id="inputtext">僱用</p>' + '<i class="fas fa-id-badge fa-lg" id="inputdollar"></i>' + '<input type="text" id="inputin" placeholder="0"></input>' + '     <button class="rounded-corners  grpelem ripple" onclick="hireperson(this)" id="u673-5"><!-- content -->' + '      <p id="u673-2">僱用</p>' + '     </button>' + '</div>' + '</div>';

    $("#pu657").append(base);
}

function openBonus(t) {
    playClickSound();
    var base = '<div id="input">' + '<div id="darken"><div>' + '<div id="inputfield" class="slide-top">' + '        <p id="inputtext">輸入花紅</p>' + '<i class="fas fa-dollar-sign fa-lg" id="inputdollar"></i>' + '<input type="text" id="inputin" placeholder="0"></input>' + '     <button class="rounded-corners  grpelem ripple" data-identifier="' + t.dataset.identifier + '" onclick="givebonus(this)" id="u673-5"><!-- content -->' + '      <p id="u673-2">給予</p>' + '     </button>' + '</div>' + '</div>';
    
    $("#pu657").append(base);
}

function openWithdraw() {
    playClickSound();
    var base = '<div id="input">' + '<div id="darken"><div>' + '<div id="inputfield" class="slide-top">' + '        <p id="inputtext">提取</p>' + '<i class="fas fa-dollar-sign fa-lg" id="inputdollar"></i>' + '<input type="text" id="inputin" placeholder="0"></input>' + '     <button class="rounded-corners  grpelem ripple" onclick="withdrawAmount(this)" id="u673-5"><!-- content -->' + '      <p id="u673-2">提取</p>' + '     </button>' + '</div>' + '</div>';

    $("#pu657").append(base);
}

function openDeposit() {
    playClickSound();
    var base = '<div id="input">' + '<div id="darken"><div>' + '<div id="inputfield" class="slide-top">' + '        <p id="inputtext">存入</p>' + '<i class="fas fa-dollar-sign fa-lg" id="inputdollar"></i>' + '<input type="text" id="inputin" placeholder="0"></input>' + '     <button class="rounded-corners  grpelem ripple" onclick="depositAmount(this)" id="u673-5"><!-- content -->' + '      <p id="u673-2">存入</p>' + '     </button>' + '</div>' + '</div>';

    $("#pu657").append(base);
}

function sureWindow(t) {
    playClickSound();

    var base = '<div id="input">' + '<div id="darken"><div>' + '<div id="inputfield" class="slide-top">' + '        <p id="inputtext">你確定?</p>' + '        <p id="inputothertext">你想解僱 ' + $(t).parent().find("#u746").text() + '</p>' + '     <button class="rounded-corners" data-identifier="' + t.dataset.identifier + '"  grpelem ripple" onclick="fire(this)" id="u673-5"><!-- content -->' + '      <p id="u673-2">是</p>' + '     </button>' + '</div>' + '</div>';

    $("#pu657").append(base);
}

function openRanks(t) {
    playClickSound();
    var base = '<div id="input">' + '<div id="darken"><div>' + '<div id="inputfield" class="slide-top">' + '        <p id="inputtext">職級</p>' + '      <div id="ranklist">';

    for (i = 0; i < currentRanks.length; i ++) {
        base = base + '<div id="rankentry" data-identifier="' + t.dataset.identifier + '" data-grade="' + currentRanks[i].grade + '" onclick="promote(this)" class="ripple">' + currentRanks[i].grade_label.toUpperCase() + '</div>';
    }
    base = base + '</div>' + '</div>' + '</div>';
    $("#pu657").append(base);
}

function hireperson(t) {
    playClickSound();
    var id = $(t).parent().find('#inputin').val();

    $.post('https://NR_Jobutilities/close', JSON.stringify({}));
        $("#main_container").fadeOut("slow", function () {
        $("#main_container").html("").fadeIn();
    });

    $.post('https://NR_Jobutilities/hire', JSON.stringify({job: currentBossMenuJob, id: id}));
}

function withdrawAmount(t) {
    playClickSound();
    var amount = $(t).parent().find('#inputin').val();

    $.post('https://NR_Jobutilities/close', JSON.stringify({}));
        $("#main_container").fadeOut("slow", function () {
        $("#main_container").html("").fadeIn();
    });

    $.post('https://NR_Jobutilities/withdraw', JSON.stringify({job: currentBossMenuJob, amount: amount}));
}


function givebonus(t) {
    playClickSound();
    var amount = $(t).parent().find('#inputin').val();
    var identifier = t.dataset.identifier;

    $.post('https://NR_Jobutilities/close', JSON.stringify({}));
        $("#main_container").fadeOut("slow", function () {
        $("#main_container").html("").fadeIn();
    });

    $.post('https://NR_Jobutilities/givebonus', JSON.stringify({identifier: identifier, amount: amount, job: currentBossMenuJob}));
}


function depositAmount(t) {
    playClickSound();
    var amount = $(t).parent().find('#inputin').val();

    $.post('https://NR_Jobutilities/close', JSON.stringify({}));
        $("#main_container").fadeOut("slow", function () {
        $("#main_container").html("").fadeIn();
    });

    $.post('https://NR_Jobutilities/deposit', JSON.stringify({job: currentBossMenuJob, amount: amount}));
}

function fire(t) {
    playClickSound();
    var identifier = t.dataset.identifier;

    $.post('https://NR_Jobutilities/close', JSON.stringify({}));
        $("#main_container").fadeOut("slow", function () {
        $("#main_container").html("").fadeIn();
    });

    $.post('https://NR_Jobutilities/fire', JSON.stringify({identifier: identifier, job: currentBossMenuJob}));
}

function promote(t) {
    playClickSound();
    var rank = t.dataset.grade;
    var identifier = t.dataset.identifier;

    $.post('https://NR_Jobutilities/close', JSON.stringify({}));
        $("#main_container").fadeOut("slow", function () {
        $("#main_container").html("").fadeIn();
    });

    $.post('https://NR_Jobutilities/setrank', JSON.stringify({identifier: identifier, rank: rank, job: currentBossMenuJob}));
}

function openJobCenter(defaultJobs) {
    var base = '<div id="jobcenter">';

    for (i = 0; i < defaultJobs.length; i ++) {
        var text = '選擇';
        if (defaultJobs[i].job == job) {
            text = '已選擇';
        }
        base = base + '<div class="shadow gradient rounded-corners colelem animated fadeInUp" id="u712">' + '    <div class="clearfix grpelem" id="u465-4"><!-- content -->' + '      <p>' + defaultJobs[i].label + '</p>' + '     </div>' + '     <button class="rounded-corners grpelem ripple addjob" data-job="' + defaultJobs[i].job + '" id="u468-4"><!-- content -->' + text + '     </button>' + '     <div class="grpelem" id="u474"><i class="' + defaultJobs[i].icon + ' fa-3x"></i><!-- simple frame --></div>' + '     <div class="clearfix grpelem" id="u477-4"><!-- content -->' + '      <p>' + defaultJobs[i].description + '</p>' + '     </div>' + '     </div>';
    }
    base = base + '   </div>';
    $("#main_container").html(base);
}


window.addEventListener('message', function (event) {
    var edata = event.data;

    if (edata.type == "openBoss") {
        job = edata.job.job;
        grade = edata.job.grade;
        
        openBossMenu(edata.bossJob, edata.bossLabel, edata.employees, edata.fund, edata.perms.canWithdraw, edata.perms.canDeposit, edata.perms.canHire, edata.perms.canRank, edata.perms.canFire, edata.grades, edata.perms.canBonus);
    } else if (edata.type == "openCenter") {
        job = edata.job.job;
        grade = edata.job.grade;
        offduty = edata.offduty;
        const centerJobs = JSON.parse(edata.center);
        openJobCenter(centerJobs);

        $(".addjob").click(function () {
            playClickSound();
            if ($(this).text().replace(/ /g, '') != 'SELECTED') {
                $(document).find(".addjob").text('選擇');
                $(this).text('已選擇');
                $.post('https://NR_Jobutilities/addjob', JSON.stringify({job: this.dataset.job}));
            }
        });
    }
});
