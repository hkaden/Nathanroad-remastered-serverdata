var table = []
var windowIsOpened = false
var selectedWindow = "none"
var item = null

// Windows
window.addEventListener('message', function(event) {
	item = event.data;
	console.log(item)
	switch (event.data.action) {
		case 'mainmenu':
			if (!windowIsOpened) {
				var popup = new Audio('popup.mp3');
				popup.volume = 0.4;
				popup.play();

				windowIsOpened = true

					row = `	<div class="col col-md-4">
								<div class="card h-100">
								<div class="card-body text-center mainmenu-subcard" id="menuMyGang" style="background-color: #eeeff3; color: #2f3037;">
									<span class="card-title" style="font-size: 30px;"><i class="fas fa-user"></i></span>
									<p class="card-text">我的幫會</p>
								</div>
								</div>
							</div>
							<div class="col col-md-4">
								<div class="card h-100">
								<div class="card-body text-center mainmenu-subcard" data-toggle="modal" data-target="#showCeateGangModal" id="menuCreateGang" style="background-color: #eeeff3; color: #2f3037;">
									<span class="card-title" style="font-size: 30px;"><i class="fas fa-building"></i></span>
									<p class="card-text">創建幫會</p>
								</div>
								</div>
							</div>
							<div class="col col-md-4">
								<div class="card h-100">
								<div class="card-body text-center mainmenu-subcard" id="menuGangRank" style="background-color: #eeeff3; color: #2f3037;">
									<span class="card-title" style="font-size: 30px;"><i class="fas fa-paper-plane"></i></span>
									<p class="card-text">幫會排名</p>
								</div>
								</div>
							</div>
						`


				$(".mainmenu").fadeIn();
				$("#mainMenuData").html(row);
				selectedWindow = "mainMenu"
			}
			break
		case 'mygangs':
			if (!windowIsOpened) {
				var popup = new Audio('popup.mp3');
				popup.volume = 0.4;
				popup.play();

				var row = "";
				$("#myGangName").html(event.data.gangName);
				console.log(event.data.players)
				for(var i=0; i<event.data.players.length; i++)
				{
					var player = event.data.players[i];
					var tablestatus = "";
					var buttonGroup = "";
					if (player.isOnline) {
						tablestatus = '<td class="text-center align-middle"><span class="badge bg-success" style="font-size: 14px;"><i class="fas fa-check-circle"></i> 在線上</span></td>';
					} else {
						tablestatus = '<td class="text-center align-middle"><span class="badge bg-secondary" style="font-size: 14px;"><i class="fas fa-minus-circle"></i> 離線</span></td>';

					}

					if (player.isMe){
						buttonGroup = `
						<td class="text-center align-middle">
						<button type="button" class="btn btn-danger quitGang" style="border-radius: 10px; flex-basis: 100%; flex-grow-1; font-size: 15px;"><i class="fas fa-monument"></i> 退出幫派</button>
						</td>`
					} else if (player.canKickMember && player.canProveAndDemote){
						buttonGroup = `
						<td class="text-center align-middle">
						<div class="btn-group" role="group" aria-label="Basic mixed styles example">
						<button type="button" class="btn btn-success flex-grow-1 provePlayer"  style="border-radius: 10px; flex-basis: 100%; margin-right: 5px;"  data-playerIdentifier="${player.identifier}"><i class="fas fa-sort-up"></i></button>
						<button type="button" class="btn btn-warning flex-grow-1 demotePlayer"  style="border-radius: 10px; flex-basis: 100%; margin-right: 5px;" data-playerIdentifier="${player.identifier}"><i class="fas fa-sort-down"></i></button>
						<button type="button" class="btn btn-danger flex-grow-1 kickPlayer"  style="border-radius: 10px; flex-basis: 100%; margin-right: 5px;" data-playerIdentifier="${player.identifier}"><i class="fas fa-times"></i></button>
					  </div></td>`
					} else if (player.canKickMember) {
						buttonGroup = `
						<td class="text-center align-middle">
						<button type="button" class="btn btn-danger kickPlayer" style="border-radius: 10px; flex-basis: 100%; font-size: 15px;" data-playerIdentifier="${player.identifier}"><i class="fas fa-times"></i> 踢出成員</button>
						</td>`
					} else {
						buttonGroup = ``
					}
					row += `
						<tr>
							<td class="text-center align-middle">${player.name}</td>
							${tablestatus}
							<td class="text-center align-middle">${player.crewGrade}</td>
							${buttonGroup}
						</tr>
					`;

					// var modal = `<div class="modal fade" id="showInvoiceModal${invoices.id}" tabindex="-1">
					// 				<div class="modal-dialog modal-dialog-centered">
					// 					<div class="modal-content myinvoices_modal-content">
					// 						<div class="modal-body p-4">
					// 							<span class="menutitle">賬單 #${invoices.id}</span>
					// 							${modalstatus}
					// 							<h6 class="" id="" style="">發出於: ${invoices.sent_date}</h6>
					// 							${limit_pay_date}
					// 							<h6 class="" id="" style="margin-top: 20px;">發出至: <span style="color: #2f3037;">${invoices.receiver_name}</span></h6>
					// 							<h6 class="" id="" style="">由: <span style="color: #2f3037;">${invoices.author_name}</span></h6>
					// 							<hr>
					// 							<div class="d-flex justify-content-between">
					// 								<span class="" id="" style="color: #2f3037; font-size: 20px;">${invoices.item}</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value - Math.round(invoices.invoice_value * (event.data.VAT/100))).toLocaleString()} &euro;</span>
					// 							</div>
					// 							<hr>
					// 							<div class="d-flex justify-content-between">
					// 								<span class="" id="" style="color: #2f3037; font-size: 20px;">小計</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value - Math.round(invoices.invoice_value * (event.data.VAT/100))).toLocaleString()} &euro;</span>
					// 							</div>
					// 							<div class="d-flex justify-content-between">
					// 								<span class="" id="" style="color: #2f3037; font-size: 20px;">稅款 (${event.data.VAT}%)</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value * (event.data.VAT/100)).toLocaleString()} &euro;</span>
					// 							</div>
					// 							<br>
					// 							<div class="d-flex justify-content-between">
					// 								<span class="" id="" style="color: #2f3037; font-size: 20px; font-weight: 700;">總額</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value).toLocaleString()} &euro;</span>
					// 							</div>
					// 							<br>
					// 							<div class="d-flex justify-content-center">
					// 								${payment_status}
					// 							</div>
					// 							<br>
					// 							<div class="d-flex justify-content-center">
					// 								<textarea class="form-control" readonly>${invoices.notes}</textarea>
					// 							</div>
					// 						</div>
					// 					</div>
					// 				</div>
					// 			</div>
					// 			`;
					// $("body").append(modal);
				}
				$("#myInvoicesData").html(row);

				const myinvoices = document.getElementById('myInvoices');
				table.push(new simpleDatatables.DataTable(myinvoices, {
					searchable: true,
					perPageSelect: false,
					perPage: 5,
				}));

				windowIsOpened = true

				selectedWindow = "myinvoices"
				$(".myinvoices").fadeIn();
			}
			break
		case 'createinvoice':
			if (!windowIsOpened) {
				windowIsOpened = true
				$("#sendInvoiceSubtitle").html(event.data.society);
				$(".sendinvoice").fadeIn();
				selectedWindow = "createinvoice"
			}
			break
		case 'societyinvoices':
			if (!windowIsOpened) {
				var popup = new Audio('popup.mp3');
				popup.volume = 0.4;
				popup.play();

				var row = "";

				for(var i=0; i<event.data.invoices.length; i++)
				{
					var invoices = event.data.invoices[i];
					var data = event.data
					var tablestatus = "";

					$("#societyInvoicesTitle").html(invoices.society_name);
					$("#totalInvoices").html(data.totalInvoices);
					$("#totalIncome").html(`${data.totalIncome.toLocaleString()}€`);
					$("#unpaidInvoices").html(data.totalUnpaid);
					$("#awaitedIncome").html(`${data.awaitedIncome.toLocaleString()}€`);

					if (invoices.status == 'paid') {
						tablestatus = '<td class="text-center align-middle"><span class="badge bg-success" style="font-size: 14px;"><i class="fas fa-check-circle"></i> 已付款</span></td>';
						modalstatus = '<span class="badge bg-success" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-check-circle"></i> 已付款</span>';
						payment_status = `<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">付款於: ${invoices.paid_date}</span>`;
					}
					else if (invoices.status == 'unpaid') {
						tablestatus = '<td class="text-center align-middle"><span class="badge bg-danger" style="font-size: 14px;"><i class="fas fa-times-circle"></i> 未付款</span></td>';
						modalstatus = '<span class="badge bg-danger" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-times-circle"></i> 未付款</span>';
						payment_status = `<button type="button" id="" class="btn btn-red flex-grow-1 cancelInvoice" style="border-radius: 10px; flex-basis: 100%;" data-invoiceId="${invoices.id}" data-invoiceMoney="${invoices.invoice_value}" data-bs-dismiss="modal"><i class="fas fa-times-circle"></i> 取消賬單</button>`;
					}
					else if (invoices.status == 'autopaid') {
						tablestatus = '<td class="text-center align-middle"><span class="badge bg-info" style="font-size: 14px;"><i class="fas fa-clock"></i> 自動付款</span></td>';
						modalstatus = '<span class="badge bg-info" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-clock"></i> 自動付款</span>';
						payment_status = `<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">自動付款於: ${invoices.paid_date}</span>`;
					}
					else if (invoices.status == 'cancelled') {
						tablestatus = '<td class="text-center align-middle"><span class="badge bg-secondary" style="font-size: 14px;"><i class="fas fa-minus-circle"></i> 已取消</span></td>';
						modalstatus = '<span class="badge bg-secondary" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-minus-circle"></i> 已取消</span>';
						payment_status = '<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">已取消</span>'
					}

					if (invoices.limit_pay_date == 'N/A') {
						limit_pay_date = ''
					} else {
						limit_pay_date = `<h6>到期日: ${invoices.limit_pay_date}</h6>`
					}

					row += `
						<tr>
							<td class="text-center align-middle">${invoices.id}</td>
							${tablestatus}
							<td class="text-center align-middle">${invoices.receiver_name}</td>
							<td class="text-center align-middle">${invoices.item}</td>
							<td class="text-center align-middle">${invoices.invoice_value.toLocaleString()}€</td>
							<td class="text-center align-middle"><button type="button" class="btn btn-blue showInvoice" style="border-radius: 10px; flex-basis: 100%;" data-toggle="modal" data-target="#showInvoiceModal${invoices.id}" data-invoiceId="${invoices.id}""><i class="fas fa-eye"></i> 賬單詳情</button></td>
						</tr>
					`;

					var modal = `<div class="modal fade" id="showInvoiceModal${invoices.id}" tabindex="-1">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content myinvoices_modal-content">
											<div class="modal-body p-4">
												<span class="menutitle">賬單 #${invoices.id}</span>
												${modalstatus}
												<h6 class="" id="" style="">發出於: ${invoices.sent_date}</h6>
												${limit_pay_date}
												<h6 class="" id="" style="margin-top: 20px;">發出至: <span style="color: #2f3037;">${invoices.receiver_name}</span></h6>
												<h6 class="" id="" style="">由: <span style="color: #2f3037;">${invoices.author_name}</span></h6>
												<hr>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">${invoices.item}</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value - Math.round(invoices.invoice_value * (event.data.VAT/100))).toLocaleString()} &euro;</span>
												</div>
												<hr>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">小計</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value - Math.round(invoices.invoice_value * (event.data.VAT/100))).toLocaleString()} &euro;</span>
												</div>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">稅款 (${event.data.VAT}%)</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value * (event.data.VAT/100)).toLocaleString()} &euro;</span>
												</div>
												<br>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px; font-weight: 700;">總額</span> <span class="" id="" style="font-size: 18px;">${Math.round(invoices.invoice_value).toLocaleString()} &euro;</span>
												</div>
												<br>
												<div class="d-flex justify-content-center">
													${payment_status}
												</div>
												<br>
												<div class="d-flex justify-content-center">
													<textarea class="form-control" readonly>${invoices.notes}</textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
								`;
					$("body").append(modal);
				}
				$("#societyInvoicesData").html(row);

				const societyinvoices = document.getElementById('societyInvoices');
				table.push(new simpleDatatables.DataTable(societyinvoices, {
					searchable: true,
					perPageSelect: false,
					perPage: 5,
				}));

				windowIsOpened = true

				selectedWindow = "societyinvoices"
				$(".societyinvoices").fadeIn();
			}
			break
	}
});

function CloseUI(className) {
	$(className).fadeOut();
	setTimeout(function(){
		windowIsOpened = false

		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$(".modal").remove();
	}, 400);
	$.post('https://CrewSystem/action', JSON.stringify({
		action: "close",
	}));
}
// Button Actions
$(document).on('click', ".showInvoice", function() {
	var modalId = $(this).attr('data-target');
	var invoiceModal = new bootstrap.Modal(modalId);
	invoiceModal.show()
});


$(document).on('click', ".provePlayer", function() {
	var playerIdentifier = $(this).attr('data-playerIdentifier');
	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "provePlayer",
		target_identifier: playerIdentifier,
	}));
	CloseUI(".myinvoices")
});

$(document).on('click', ".demotePlayer", function() {
	var playerIdentifier = $(this).attr('data-playerIdentifier');
	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "demotePlayer",
		target_identifier: playerIdentifier,
	}));
	CloseUI(".myinvoices")
});

$(document).on('click', ".kickPlayer", function() {
	var playerIdentifier = $(this).attr('data-playerIdentifier');
	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "kickPlayer",
		target_identifier: playerIdentifier,
	}));
	CloseUI(".myinvoices")
});

$(document).on('click', ".quitGang", function() {
	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "quitGang"
	}));
	CloseUI(".myinvoices")
});



$(document).on('click', ".payInvoice", function() {
	var invoiceId = $(this).attr('data-invoiceId');

	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "payInvoice",
		invoice_id: invoiceId,
	}));

	$(".myinvoices").fadeOut();

	setTimeout(function(){
		windowIsOpened = false

		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$(".modal").remove();
	}, 400);
});

$(document).on('click', ".cancelInvoice", function() {
	var invoiceId = $(this).attr('data-invoiceId');

	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "cancelInvoice",
		invoice_id: invoiceId,
	}));

	$(".societyinvoices").fadeOut();

	setTimeout(function(){
		windowIsOpened = false

		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$(".modal").remove();
	}, 400);
});

$(document).on('click', '#menuMyInvoices', function() {
	windowIsOpened = false
	$(".mainmenu").fadeOut();

	$.post('http://NR_Billing/action', JSON.stringify ({
		action: "mainMenuOpenMyInvoices"
	}));
})

$(document).on('click', '#menuMyGang', function() {
	windowIsOpened = false
	$(".mainmenu").fadeOut();

	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "mainMenuOpenMyGangs"
	}));
})

$(document).on('click', '#menuGangRank', function() {
	windowIsOpened = false
	$(".mainmenu").fadeOut();

	$.post('https://CrewSystem/action', JSON.stringify ({
		action: "menuGangRank"
	}));
})

$(document).on('click', '#menuCreateGang', function() {
	windowIsOpened = false
	$(".mainmenu").fadeOut();
	$(".createGang").fadeIn();
	selectedWindow = "createGang"
})

$(document).on('click', '.inviteMemberButton', function() {
	windowIsOpened = false
	$(".myinvoices").fadeOut();
	$(".inviteMember").fadeIn();
	selectedWindow = "inviteMember"
})



$(document).on('click', '#sendInviteMember', function() {
	var targetID = $("#targetID").val();

	if(!targetID) {
		$.post('https://CrewSystem/action', JSON.stringify({
			action: "missingInfo",
		}));
	} else {
			$(".inviteMember").fadeOut();
			windowIsOpened = false

			$.post('https://CrewSystem/action', JSON.stringify({
				action: "sendInviteMember",
				targetID: targetID
			}));

			setTimeout(function() {
				for(var i=0; i<table.length; i++) {
					table[i].destroy();
					table.splice(i, 1);
				}
				$("#targetID").val("");
			}, 400);

			$.post('https://CrewSystem/action', JSON.stringify({
				action: "close",
			}));
	}
})


$(document).on('click', '#sendCreateGang', function() {
	var gang_name = $("#gang_name").val();

	if(!gang_name) {
		$.post('https://CrewSystem/action', JSON.stringify({
			action: "missingInfo",
		}));
	} else {

			$(".createGang").fadeOut();
			windowIsOpened = false

			$.post('https://CrewSystem/action', JSON.stringify({
				action: "sendCreateGang",
				gang_name: gang_name
			}));

			setTimeout(function() {
				for(var i=0; i<table.length; i++) {
					table[i].destroy();
					table.splice(i, 1);
				}
				$("#gang_name").val("");
			}, 400);

			$.post('https://CrewSystem/action', JSON.stringify({
				action: "close",
			}));
	}
})

$(document).on('click', "#closeMainMenu", function() {
	var popuprev = new Audio('popupreverse.mp3');
	popuprev.volume = 0.4;
	popuprev.play();

	windowIsOpened = false
	$(".mainmenu").fadeOut();

	$.post('https://CrewSystem/action', JSON.stringify({
		action: "close",
	}));
});

$(document).on('click', "#closeCrateGang", function() {
	var popuprev = new Audio('popupreverse.mp3');
	popuprev.volume = 0.4;
	popuprev.play();

	$(".createGang").fadeOut();

	setTimeout(function() {
		windowIsOpened = false

		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$("#gang_name").val("");
		$(".modal").remove();
	}, 400);

	$.post('https://CrewSystem/action', JSON.stringify({
		action: "close",
	}));
});

$(document).on('click', "#closeSocietyInvoices", function() {
	var popuprev = new Audio('popupreverse.mp3');
	popuprev.volume = 0.4;
	popuprev.play();

	$(".societyinvoices").fadeOut();

	setTimeout(function() {
		windowIsOpened = false

		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$(".modal").remove();
	}, 400);

	$.post('https://CrewSystem/action', JSON.stringify({
		action: "close",
	}));
});

$(document).on('click', "#closeMyInvoices", function() {
	var popuprev = new Audio('popupreverse.mp3');
	popuprev.volume = 0.4;
	popuprev.play();

	$(".myinvoices").fadeOut();

	setTimeout(function() {
		windowIsOpened = false

		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$(".modal").remove();
	}, 400);

	$.post('https://CrewSystem/action', JSON.stringify({
		action: "close",
	}));
});

$(document).on('click', "#closeinviteMember", function() {
	var popuprev = new Audio('popupreverse.mp3');
	popuprev.volume = 0.4;
	popuprev.play();

	$(".inviteMember").fadeOut();

	setTimeout(function() {
		windowIsOpened = false

		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$(".modal").remove();
	}, 400);

	$.post('https://CrewSystem/action', JSON.stringify({
		action: "close",
	}));
});

// Close ESC Key
$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
			var popuprev = new Audio('popupreverse.mp3');
			popuprev.volume = 0.4;
			popuprev.play();
			switch (selectedWindow) {
				case 'myinvoices':
					$(".myinvoices").fadeOut();

					setTimeout(function() {
						windowIsOpened = false

						for(var i=0; i<table.length; i++) {
							table[i].destroy();
							table.splice(i, 1);
						}

						$(".modal").remove();
					}, 400);

					$.post('https://CrewSystem/action', JSON.stringify({
						action: "close",
					}));
					break
				case 'mainMenu':
					windowIsOpened = false

					$(".mainmenu").fadeOut();

					$.post('https://CrewSystem/action', JSON.stringify({
						action: "close",
					}));
					break
				case 'societyinvoices':
					$(".societyinvoices").fadeOut();

					setTimeout(function() {
						windowIsOpened = false

						for(var i=0; i<table.length; i++) {
							table[i].destroy();
							table.splice(i, 1);
						}

						$(".modal").remove();
					}, 400);

					$.post('https://CrewSystem/action', JSON.stringify({
						action: "close",
					}));
					break
				case 'createGang':
					$(".createGang").fadeOut();

					setTimeout(function() {
						windowIsOpened = false

						for(var i=0; i<table.length; i++) {
							table[i].destroy();
							table.splice(i, 1);
						}

						$(".modal").remove();
					}, 400);

					$.post('https://CrewSystem/action', JSON.stringify({
						action: "close",
					}));
					break
				case 'inviteMember':
					$(".inviteMember").fadeOut();

					setTimeout(function() {
						windowIsOpened = false

						for(var i=0; i<table.length; i++) {
							table[i].destroy();
							table.splice(i, 1);
						}

						$(".modal").remove();
					}, 400);

					$.post('https://CrewSystem/action', JSON.stringify({
						action: "close",
					}));
					break
			}
		}
	};
});