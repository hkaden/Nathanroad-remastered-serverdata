var sound = new Audio('sound.wav');
    sound.volume = 1.0;

function closeMain() {
	$("body").css("display", "none");
}
function openMain() {
	$("body").css("display", "block");
}
function closeAll() {
	$(".body").css("display", "none");
}
$(".close").click(function(){
    $.post('https://lab-Territories/quit', JSON.stringify({}));
});

window.addEventListener('message', function (event) {

	var item = event.data;

	if (item.message == "show") {
		openMain();
		$( ".dates-div" ).empty();
		$( ".full-screen" ).empty();
		$( ".shopui" ).empty();
	}

	if (item.message == "hide") {
		closeMain();
	}

	if (item.message == "addDate") {
		$( ".dates-div" ).append('<h4 style="white-space: nowrap; font-size: 0.8vw;padding: 5px;margin-bottom: 1em;"><b>日期: <span style="color:#00f62d;">' + item.day + '</span> | 時間: <span style="color:#00f62d;">' + item.hour + ':00</span></b></h4>');
	}

	if (item.message == "prepareshop"){
		$( ".shopui" ).empty();
	}
	if (item.message == "shop"){
		$( ".shopui" ).append('<div class="card" onmouseenter="sound.play();">' +
		'<div class="image-holder" style=" background:rgba(0,0,0,0.3);border-radius:10px;">' +
			'<img src="img/items/' + item.item + '.png" onerror="this.src = \'img/default.png\'" alt="' + item.label + '" style="width:100%;">' +
		'</div>' +
		'<div class="container" style=" max-width: 100%;overflow: hidden;text-overflow: ellipsis;">' +
			'<h4 style="white-space: nowrap; font-size: 1.2vw;"><b>' + item.label + '<div class="price"><span style="color:#00f62d;font-size: 1.0vw;">$' + item.price + '</span>' + '</div>' +'</b></h4> ' +
			'<div class="purchase">' +

				'<div class="buy" name="' + item.item + '"><span style="font-size: 1.2vw;">購買</span></div>' +
			'</div>' +
		'</div>' +
	'</div>');
	}

	if (item.message == "preparedealer"){
		$( ".shopui" ).empty();
	}
	if (item.message == "dealer"){
		$( ".shopui" ).append('<div class="card" onmouseenter="sound.play();">' +
		'<div class="image-holder" style=" background:rgba(0,0,0,0.3);border-radius:10px;">' +
			'<img src="img/items/' + item.item + '.png" onerror="this.src = \'img/default.png\'" alt="' + item.label + '" style="width:100%;">' +
		'</div>' +
		'<div class="container" style=" max-width: 100%;overflow: hidden;text-overflow: ellipsis;">' +
			'<h4 style="white-space: nowrap; font-size: 1.2vw;"><b>' + item.label + '<div class="price"><span style="color:#00f62d;font-size: 1.0vw;">$' + item.price + '</span> Each' + '</div>' +'</b></h4> ' +
			'<div class="purchase">' +

				'<div class="sell" name="' + item.item + '"><span style="font-size: 1.2vw;">SELL</span></div>' +
			'</div>' +
		'</div>' +
	'</div>');
	}
});



$(".shopui").on("click", ".buy", function() {
	var $button = $(this);
	var $name = $button.attr('name')

	$.post('https://lab-Territories/purchase', JSON.stringify({
		item: $name
	}));

});

$(".shopui").on("click", ".sell", function() {
	var $button = $(this);
	var $name = $button.attr('name')

	$.post('https://lab-Territories/sell', JSON.stringify({
		item: $name
	}));

});


$(".claim").on("click", function() {
	$.post('https://lab-Territories/claim', JSON.stringify({}));
	$.post('https://lab-Territories/quit', JSON.stringify({}));
});

$(".shop").on("click", function() {
	$.post('https://lab-Territories/shop', JSON.stringify({}));
});

$(".dealer").on("click", function() {
	$.post('https://lab-Territories/dealer', JSON.stringify({}));
});

$(".claim").on("mouseenter", function() {
	sound.play();
});

$(".shop").on("mouseenter", function() {
	sound.play();
});

$(".dealer").on("mouseenter", function() {
	sound.play();
});

$(".btn").on("mouseenter", ".close", function() {
	sound.play();
});