var selectedWindow = "none"
var sourceID = 0
var targetID = 0
var sourceName = ""
var targetName = ""
var targetNameSeller = ""
var vehLabel = ""
var vehicleModel = ""
var plateNumber = ""
var date = ""
var description = ""
var price = 0

window.addEventListener('message', function(event) {
	switch (event.data.action) {
		case 'openContractSeller':
			$("#source_name").html(event.data.source_playername);
			$("#target_name").html(event.data.target_playername);
			$("#vehicle_label").html(event.data.vehLabel);
			$("#vehicle_model").html(event.data.model);
			$("#plate_number").html(event.data.plate);
			$("#date").html(event.data.date);
			$("#description").html(event.data.description);
			$("#price").html(event.data.price);

			sourceID = event.data.sourceID;
			targetID = event.data.targetID;
			sourceName = event.data.source_playername;
			targetName = event.data.target_playername;
			vehLabel = event.data.vehLabel;
			vehicleModel = event.data.model;
			plateNumber = event.data.plate;
			date = event.data.date;
			description = event.data.description;
			price = event.data.price;

			$("#signtest").html("");
			$("#signtest2").html("");
			$("#signContract1").attr("disabled", false);

			$("#signContract1").removeClass('d-none');
			$("#signContract2").addClass('d-none');

			$(".contract1").fadeIn();

			selectedWindow = "openContractSeller"
			break
		case 'openContractInfo':
			$(".vehicleInformation").fadeIn();
			// $("#vehicle_description").val(event.data.vehLabel);
			// $("#vehicle_price").val(event.data.price);

			selectedWindow = "openContractInfo"
			break
		case 'openContractOnBuyer':
			$("#source_name").html(event.data.source_playername);
			$("#target_name").html(event.data.target_playername);
			$("#vehicle_label").html(event.data.vehLabel);
			$("#vehicle_model").html(event.data.model);
			$("#plate_number").html(event.data.plate);
			$("#date").html(event.data.date);
			$("#description").html(event.data.description);
			$("#price").html(event.data.price);

			sourceNameSeller = event.data.source_playername;
			targetNameSeller = event.data.target_playername;
			targetIDSeller = event.data.targetID;
			sourceIDSeller = event.data.sourceID;
			plateNumberSeller = event.data.plate;
			vehLabelSeller = event.data.vehLabel;
			modelSeller = event.data.model;
			vehicle_price = event.data.price;

			$("#signtest").html("");
			$("#signtest2").html("");
			$("#signContract2").attr("disabled", false);

			var sellerSignatureP = new Vara("#signtest","SatisfySL.json", [{
				text: event.data.source_playername,
				fontSize: 18, 
				strokeWidth: 2,
				color: "#000",
				id: "",
				duration: 0,
				textAlign: "center",
				x: 0,
				y: 0, 
				fromCurrentPosition:{ 
					x: true,
					y: true,
				},
				autoAnimation: true,
				queued: true,
				delay: 0,
				letterSpacing: 0
			}]);

			$("#signContract1").addClass('d-none');
			$("#signContract2").removeClass('d-none');

			$(".contract1").fadeIn();

			selectedWindow = "openContractOnBuyer"
			break
	}
});

// Button Actions
$(document).on('click', '#submitContractInfo', function() {
	var vehicle_description = $("#vehicle_description").val();
	var vehicle_price = $("#vehicle_price").val();

	if(!vehicle_description || !vehicle_price) {
		$.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
			action: "missingInfo",
		}));
	} else {
		$(".vehicleInformation").fadeOut();

		$.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
			action: "submitContractInfo",
			vehicle_description: vehicle_description,
			vehicle_price: vehicle_price,
		}));

		setTimeout(function() {
			$("#vehicle_description").val("");
			$("#vehicle_price").val("");
		}, 400);
	}
})

$(document).on('click', "#signContract1", function() {
	var sellerSignature = new Vara("#signtest","SatisfySL.json", [{
		text: sourceName,
		fontSize: 18, 
		strokeWidth: 2,
		color: "#000",
		id: "",
		duration: 3000,
		textAlign: "center",
		x: 0,
		y: 0, 
		fromCurrentPosition:{ 
			x: true,
			y: true,
		},
		autoAnimation: true,
		queued: true,
		delay: 0,
		letterSpacing: 0
	}]);

	$("#signContract1").attr("disabled", true);

	setTimeout(function(){
		$.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
			action: "signContract1",
			sourceID: sourceID,
			targetID: targetID,
			sourceName: sourceName,
			targetName: targetName,
			vehLabel: vehLabel,
			vehicleModel: vehicleModel,
			plateNumber: plateNumber,
			date: date,
			description: description,
			price: price,
		}));

		$(".contract1").fadeOut();
	}, 6000);
});

$(document).on('click', "#signContract2", function() {
	var buyerSignature = new Vara("#signtest2","SatisfySL.json", [{
		text: targetNameSeller,
		fontSize: 18, 
		strokeWidth: 2,
		color: "#000",
		id: "",
		duration: 3000,
		textAlign: "center",
		x: 0,
		y: 0, 
		fromCurrentPosition:{ 
			x: true,
			y: true,
		},
		autoAnimation: true,
		queued: true,
		delay: 0,
		letterSpacing: 0
	}]);

	$("#signContract2").attr("disabled", true);

	setTimeout(function(){
		$.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
			action: "signContract2",
			targetIDSeller: targetIDSeller,
			plateNumberSeller: plateNumberSeller,
			sourceIDSeller: sourceIDSeller,
			vehLabelSeller: vehLabelSeller,
			modelSeller: modelSeller,
			sourceNameSeller: sourceNameSeller,
			targetNameSeller: targetNameSeller,
			vehicle_price: vehicle_price,
		}));
		
		$(".contract1").fadeOut();
	}, 6000);
});

$(document).on('click', "#closeVehicleInformation", function() {
	$(".vehicleInformation").fadeOut();

	setTimeout(function() {
		$("#vehicle_description").val("");
		$("#vehicle_price").val("");

		$.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
			action: "close",
		}));
	}, 400);
});

// Close ESC Key
$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
			switch (selectedWindow) {
				case 'openContractSeller':
					$(".contract1").fadeOut();

					$.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
						action: "close",
					}));
					break
				case 'openContractInfo':
					$(".vehicleInformation").fadeOut();

					setTimeout(function() {
						$("#vehicle_description").val("");
						$("#vehicle_price").val("");
					}, 400);

					$.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
						action: "close",
					}));
					break
				case 'openContractOnBuyer':
					$(".contract1").fadeOut();

				    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
				        action: "close",
				    }));
					break
			}
		}
	};
});