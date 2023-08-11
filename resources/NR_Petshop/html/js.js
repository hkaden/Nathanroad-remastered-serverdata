//console.log("discord.gg/debux | Tebex : debux.shop")

$(document).ready(function () {
    window.addEventListener("message", function (event) {
        //console.log(event.data.action)
        if (event.data.action == "openmenu") {
            $(".bg").css("display", "block");
        }
        if (event.data.action == "changename") {
            $(".name").html(event.data.name);
            $(".price").html("$" + event.data.price);
        }
        if (event.data.action == "changename") {
            $(".name-2").html(event.data.name);
            $(".price-2").html("$" + event.data.price);
        }
        if (event.data.action == "update") {
            $(".name").html(event.data.name);
            $(".bottom-wallet-money span").html(event.data.price);
        }
        if (event.data.action == "add-pet") {
            html =
                `
    <div class="item">
    <div class="item-text">` +
                event.data.name +
                `</div>
    <div class="item-img" style="background-image: url(./img/` +
                event.data.img +
                `);"></div>
    <div class="prew-but" onclick="pew(this.id)" id="` +
                event.data.id +
                `"><t>SHOW PET</t></div>
  </div>
  `;
            $("#kutucuk").prepend(html);
        }
        if (event.data.action == "open-menu-d") {
            $(".bg-4").css("display", "block");
        }
    });
});

$(".close-button").click(function () {
    $(".bg").css("display", "none");
    $("#kutucuk").empty();
    $.post(`https://${GetParentResourceName()}/closenui`, JSON.stringify({}));
});

function pew(id) {
    //console.log("kaka")
    //console.log(id)
    $(".bg-2").css("display", "none");
    $(".bg-3").css("display", "block");
    $("#kutucuk").empty();
    $.post(`https://${GetParentResourceName()}/showpet`, JSON.stringify({ id: id }));
}

$("#close").click(function () {
    $("#kutucuk").empty();
    $(".bg-4").css("display", "none");
    $.post(`https://${GetParentResourceName()}/closenui`, JSON.stringify({}));
});

$(".buy-button").click(function () {
    $("#kutucuk").empty();
    $(".bg-4").css("display", "none");
    $(".bg-3").css("display", "none");
    $.post(`https://${GetParentResourceName()}/closenui`, JSON.stringify({}));
    $.post(`https://${GetParentResourceName()}/cam`, JSON.stringify({}));
    $.post(`https://${GetParentResourceName()}/buy`, JSON.stringify({}));
});

$(".bg3-close").click(function () {
    $(".bg-4").css("display", "none");
    $("#kutucuk").empty();
    $(".bg-3").css("display", "none");
    $.post(`https://${GetParentResourceName()}/closenui`, JSON.stringify({}));
    $.post(`https://${GetParentResourceName()}/cam`, JSON.stringify({}));
});

function spawnpet() {
    $.post(`https://${GetParentResourceName()}/spawnpet`, JSON.stringify({}));
}

function vehicle() {
    $.post(`https://${GetParentResourceName()}/vehicle`, JSON.stringify({}));
}

function sit() {
    $.post(`https://${GetParentResourceName()}/sit`, JSON.stringify({}));
}

function sleep() {
    $.post(`https://${GetParentResourceName()}/sleep`, JSON.stringify({}));
}

function box1() {
    $.post(`https://${GetParentResourceName()}/box-menu`, JSON.stringify({}));
    $(".bg").css("display", "none");
    $("#kutucuk").empty();
    $(".bg-2").css("display", "block");
}

function box2() {
    $.post(`https://${GetParentResourceName()}/box-menu2`, JSON.stringify({}));
    $(".bg").css("display", "none");
    $("#kutucuk").empty();
    $(".bg-2").css("display", "block");
}

function back() {
    $("#kutucuk").empty();
    $(".bg").css("display", "block");
    $(".bg-2").css("display", "none");
}

function deletela() {
    $(".bg-4").css("display", "none");
    $.post(`https://${GetParentResourceName()}/delete`, JSON.stringify({}));
}
