var Config = new Object();
Config.closeKeys = [27];
Config.ATMTransLimit = 5000;
var currentLimit = null;
var clientPin = null;

window.addEventListener("message", function (event) {
    if (event.data.status == "openbank") {
        /*$("#cardDetails").css({"display":"none"});*/
        $("#createNewPin").css({ display: "none" });
        $("#successMessageATM")
            .removeClass("alert-danger")
            .addClass("alert-success");
        $("#successRowATM").css({ display: "none" });
        $("#successMessageATM").html("");
        $("#withdrawATMError").css({ display: "none" });
        $("#withdrawATMErrorMsg").html("");
        $("#savingsStatement").DataTable().destroy();
        $("#currentStatement").DataTable().destroy();
        $("#currentStatementATM").DataTable().destroy();

        $("#newPinNumber").val("");
        $("#bankingHome-tab").addClass("active");
        $("#bankingWithdraw-tab").removeClass("active");
        $("#bankingDeposit-tab").removeClass("active");
        $("#exchage-tab").removeClass("active");
        $("#bankingTransfer-tab").removeClass("active");
        $("#bankingStatement-tab").removeClass("active");
        $("#bankingActions-tab").removeClass("active");
        $("#bankingSavings-tab").removeClass("active");
        $("#bankingHome").addClass("active").addClass("show");
        $("#bankingWithdraw").removeClass("active").removeClass("show");
        $("#exchage").removeClass("active").removeClass("show");
        $("#bankingSavings").removeClass("active").removeClass("show");
        $("#bankingDeposit").removeClass("active").removeClass("show");
        $("#bankingTransfer").removeClass("active").removeClass("show");
        $("#bankingStatement").removeClass("active").removeClass("show");
        $("#bankingActions").removeClass("active").removeClass("show");

        $("#savingsStatementContents").html("");
        $("#savingsBalance").html("");
        $("#accountName2").html("");
        $("#saccountNumber").html("");
        $("#saccountSortCode").html("");
        $("#savingAccountCreator").css({ display: "block" });
        $("#savingsQuicky1").css({ display: "none" });
        $("#bankingSavings-tab").css({ display: "none" });
        $("#savingsQuicky2").css({ display: "none" });

        populateBanking(event.data.information);

        $("#bankingContainer").css({ display: "block" });
    } else if (event.data.status == "closebank") {
        $("#cardDetails").css({ display: "none" });
        $("#createNewPin").css({ display: "none" });
        $("#bankingHomeATM, #bankingWithdrawATM, #bankingStatementATM")
            .removeClass("show")
            .removeClass("active");
        $("#bankingHomeATM, #bankingWithdrawATM, #bankingStatementATM")
            .removeClass("show")
            .removeClass("active");
        $("#withdrawATMErrorMsg")
            .removeClass("alert-success")
            .addClass("alert-danger");
        $("#successMessageATM")
            .removeClass("alert-danger")
            .addClass("alert-success");
        $("#successRowATM").css({ display: "none" });
        $("#successMessageATM").html("");
        $(".shopItemContent").html("");
        $(".exchageContent").html("");
        $("#withdrawATMError").css({ display: "none" });
        $("#withdrawATMErrorMsg").html("");
        $("#savingsStatement").DataTable().destroy();
        $("#currentStatement").DataTable().destroy();
        $("#currentStatementATM").DataTable().destroy();
        $("#enteringPin").addClass("show").addClass("active");
        $(
            "#bankingHomeATM-tab, #bankingWithdrawATM-tab, #bankingTransferATM-tab, #bankingStatementATM-tab"
        )
            .addClass("disabled")
            .removeClass("active");
        $("#bankingHomeATM-tab").addClass("active");
        $("#createNewPin").css({ display: "block" });
        $("#successRow").css({ display: "none" });
        $("#successMessage").html("");
        $("#bankingContainer").css({ display: "none" });
        $("#savingsQuicky").css({ display: "none" });
        $("#savingAccountCreator").css({ display: "none" });
        $("#ATMContainer").css({ display: "none" });
    } else if (event.data.status == "transferError") {
        if (event.data.error !== undefined) {
            sendErrorAlert(event.data.error);
        }
    } else if (event.data.status == "successMessage") {
        if (event.data.message !== undefined) {
            sendSuccessAlert(event.data.message);
        }
    }
});

function sendErrorAlert(msg) {
    $.notify(
        {
            // options
            message: msg,
        },
        {
            // settings
            element: "body",
            type: "danger",
            newest_on_top: true,
            delay: 3000,
            placement: {
                from: "top",
                align: "center",
            },
            template:
                '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert" style="width: 100%">' +
                '<span data-notify="icon"></span> ' +
                '<span data-notify="title">{1}</span> ' +
                '<span data-notify="message">{2}</span>' +
                '<div class="progress" data-notify="progressbar">' +
                '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>' +
                "</div>" +
                '<a href="{3}" target="{4}" data-notify="url"></a>' +
                "</div>",
        }
    );
}

function sendSuccessAlert(msg) {
    $.notify(
        {
            // options
            message: msg,
        },
        {
            // settings
            element: "body",
            type: "success",
            newest_on_top: true,
            delay: 3000,
            placement: {
                from: "top",
                align: "center",
            },
            template:
                '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert" style="width: 100%">' +
                '<span data-notify="icon"></span> ' +
                '<span data-notify="title">{1}</span> ' +
                '<span data-notify="message">{2}</span>' +
                '<div class="progress" data-notify="progressbar">' +
                '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>' +
                "</div>" +
                '<a href="{3}" target="{4}" data-notify="url"></a>' +
                "</div>",
        }
    );
}

function populateBanking(data) {
    $("#key").val("");
    $("#customerName").html(data.name);
    $("#currentBalance").html(data.point);
    $("#currentPumpkin").html(data.pumpkin);

    if (data.shop !== undefined) {
        $.each(data.shop, function (index, shopItem) {
            if (shopItem.flag == "new") {
                flag =
                    '<div class="label new" style="background-color: #64fa78; color: #000;">新上架</div>';
            } else if (shopItem.flag == "hot") {
                flag =
                    '<div class="label new" style="background-color: #ff9191; color: #000;">熱門</div>';
            } else {
                flag = "";
            }

            if (shopItem.isLimited != 0) {
                limit =
                    '<div class="label limit" style="background-color: #90a2fc; color: #000;">剩餘 ' +
                    shopItem.buyLimit +
                    " 個</div>";
            } else {
                limit = "";
            }

            $(".shopItemContent").append(
                '<div class="col-4" style="margin-top: 25px;"><div class="productContainer">' +
                    flag +
                    limit +
                    '<img src="' +
                    shopItem.images +
                    '"style="width: 100px;"><br><span>' +
                    shopItem.name +
                    "<br/><span>單價 : " +
                    shopItem.price +
                    ' 點</span><input type="number" name="ItemValue-' +
                    shopItem.id +
                    '"class="inputVal" value="1" min="0" /> <button class="btn" style="background-color: #fbc308; color: #000; margin-top: 5px; width: 75%;" data-action="buy" data-itemId="' +
                    shopItem.id +
                    '" onclick="clickBuyBtn(this)">購買</button></div></div>'
            );
        });
    }
    if (data.exchange !== undefined) {
        $.each(data.exchange, function (index, exchangeItem) {
            $(".exchageContent").append(
                '<div class="col-12" style="margin-top: 25px;"><div class="exchangeContainer"><span>' +
                    exchangeItem.word +
                    '</span><button class="btn exchageButton" style="background-color: #fbc308; color: #000; " id="initiateWithdraw" data-action="exchange" data-itemId="' +
                    exchangeItem.id +
                    '" onclick="clickExchangeBtn(this)">購買</button></div></div>'
            );
        });
    }

    $("input[type='number']").inputSpinner();
}

function closeBanking() {
    $.post(`https://${GetParentResourceName()}/NUIFocusOff`, JSON.stringify({}));
}

function clickBuyBtn(ele) {
    var itemId = $(ele).attr("data-itemId");
    if (itemId != undefined && $("input[name='ItemValue-" + itemId).val() > 0) {
        $.post(
            `https://${GetParentResourceName()}/doBuy`,
            JSON.stringify({
                itemId: parseInt(itemId),
                val: parseInt($("input[name='ItemValue-" + itemId).val()),
            })
        );
    }
}

function clickExchangeBtn(ele) {
    var itemId = $(ele).attr("data-itemId");
    if (itemId != undefined) {
        $.post(
            `https://${GetParentResourceName()}/doExchange`,
            JSON.stringify({
                exchangeId: parseInt(itemId),
            })
        );
    }
}

$(function () {
    $("body").on("keydown", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeBanking();
        }
    });

    $("#initiateWithdraw").click(function () {
        var keyInput = $("#key").val();
        if (keyInput !== undefined && keyInput.length != 0) {
            $("#withdrawError").css({ display: "none" });
            $("#withdrawErrorMsg").html("");
            $.post(
                `https://${GetParentResourceName()}/redeemKey`,
                JSON.stringify({
                    key: keyInput,
                })
            );
            $("#key").val("");
        } else {
            // Error doing withdraw
            sendErrorAlert("請輸入序號");
        }
    });

    $("[data-action=buy]").click(function () {});

    $("#logoffbutton, #logoffbuttonatm").click(function () {
        closeBanking();
    });
});