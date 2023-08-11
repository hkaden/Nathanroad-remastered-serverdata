$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)
    window.addEventListener('message', function(event) {
        var item = event.data;
        var myPix = new Array(item.src)
        var randomNum = Math.floor(Math.random() * myPix.length);
        document.getElementById("myPicture").src = myPix[randomNum];        
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })



    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://NR_Mining/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://NR_Mining/exit', JSON.stringify({}));
        return
    })

})
