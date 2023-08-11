$(document).ready(function () {
    // LUA listener
    window.addEventListener("message", function (event) {
        if (event.data.action == "open") {
            var metadata = event.data.metadata;
            var type = event.data.metadata.cardtype;
            var licenseData = metadata.licenses;
            var sex = metadata.sex;
            var mugshot = metadata.mugshoturl;
            if (type == "identification" || type == null || type == "drivers_license" || type == "firearms_license") {
                $("img").show();
                $("#name").css("color", "#282828");
                $("#fname").css("color", "#282828");

                if (sex.toLowerCase() == "m") {
                    $("#sex").text("m");
                } else {
                    $("#sex").text("f");
                }
                $("img").attr("src", mugshot);
                $("#idnum").text(metadata.citizenid);
                $("#expiry").text(metadata.expireson);
                $("#name").text(metadata.name);
                $("#dob").text(metadata.dateofbirth);
                var inches = metadata.height;
                var feet = Math.floor(inches / 12);
                inches %= 12;
                $("#height").text(feet + "ft " + inches + "in");

                if (type == "identification") {
                    $("#id-card").css(
                        "background",
                        "url(assets/images/idcard.png)"
                    );
                } else if (type == "drivers_license") {
                    $("#licenses").text(metadata.licenses);

                    $("#id-card").css(
                        "background",
                        "url(assets/images/license.png)"
                    );
                } else if (type == "firearms_license") {
                    $("#licenses").text(metadata.licenses);
                    $("#id-card").css(
                        "background",
                        "url(assets/images/firearm.png)"
                    );
                }
            } else {
                $("#id-card").css(
                    "background",
                    "url(assets/images/idcard.png)"
                );
            }

            $("#id-card").show();
        } else if (event.data.action == "close") {
            $("#name").text("");
            $("#fname").text("");
            $("#dob").text("");
            $("#height").text("");

            $("#sex").text("");
            $("#id-card").hide();
            $("#licenses").html("");
        }
    });
});
