let toggleKeyCode = 0
let visable = false;
let selectType = "all"
let playerList = {}

function printPlayerList(type) {
	$('#playerlist').empty();
	let html = ''
	let playerList2 = []
	if (type == "all") {
		playerList2 = playerList
	} else {
		$.each(playerList, function (i, v) {
			if (v.jobType && v.jobType == type) {
				playerList2.push(v)
			}
			if (v.jobType != type && v.jobType2 == type) {
				playerList2.push(v)
			}
		})
	}

	$.each(playerList2, function (i, v) {
		if (v) {
		if (i % 3 == 0) {
			html += '<tr>'
		}
		html += `<td data-type="${v.jobType}"><span>${v.id} </span></td><td data-type="${v.jobType}">${v.name} [ ${pingColor(v.ping)} ms ]</td><td data-type="${v.jobType}">${v.job}</td>`;
		if ((i + 1) % 3 == 0) {
			html += '</tr>'
		}
	}
	})

	let addCount = 3 - (playerList2.length % 3)
	if (addCount != 3) {
		for (let i = 0; i < addCount; i++) {
			html += `<td class="empty">&nbsp;</td><td class="empty">&nbsp;</td><td class="empty">&nbsp;</td>`;
		}
	}

	$('#playerlist').html(html)
}

function sortPlayerList() {
	let table = $('#playerlist')
	let rows = $('tr:not(.heading)', table);

	rows.sort(function (a, b) {
		let keyA = $('td', a).eq(1).html();
		let keyB = $('td', b).eq(1).html();

		return (keyA - keyB);
	});

	rows.each(function (index, row) {
		table.append(row);
	});
}

function pingColor(ping) {
	if (ping > 150 && ping < 200) {
		return `<font color="orange">${ping}</font>`
	} else if (ping >= 200) {
		return `<font  color="red">${ping}</font>`
	}

	return `<font  color="#00FD15">${ping}</font>`
}

$(function () {
	$(document).keyup(function (e) {
		let keyCode = e.keyCode || e.which;
		if (keyCode == toggleKeyCode || keyCode == 27) {
			$('#wrap').fadeOut().hide()
			$.post('https://NR_PlayerList/hideList')
			visable = !visable;
		}
	});
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'init':
				// console.log(event.data.categories)
				// toggleKeyCode = event.data.toggleKey;
				let categories = event.data.categories;
				$.each(categories, function (i, v) {
					$('#tabType').append(`<p data-type="${v[1]}" class="">${v[3]} ${v[2]}: <span id="${v[1]}">0</span> </p>`)
				})
				$('#tabType p[data-type="all"]').addClass('active')

				$('.jobs p').on('click', function (e) {
					$('.jobs p').removeClass('active')
					$(e.currentTarget).addClass('active')
					let type = $(e.currentTarget).attr('data-type')
					selectType = type
					printPlayerList(selectType)
					return false;
				})
				break;
			case 'toggle':

				if (visable) {
					$('#wrap').fadeOut();
					$.post('https://NR_PlayerList/hideList')
				} else {
					$('#wrap').fadeIn();
					$.post('https://NR_PlayerList/showList')
				}

				visable = !visable;
				break;

			case 'close':
				$('#wrap').fadeOut();
				visable = false;
				break;

			case 'updatePlayerJobs':
				let jobs = event.data.jobs;
				$('#player_count').html(jobs.all);
				$.each(jobs, function (i, v) {
					$(`#${i}`).html(v);
				})
				break;

			case 'updatePing':
			    //console.log(event.data.players)
				playerList = event.data.players
				printPlayerList(selectType)
				break;
			case 'updatePlayerList':
				playerList = event.data.players
				//console.log(playerList)
				printPlayerList(selectType)
				$('#max_players').text(event.data.maxClients);
				break;

			case 'updateServerInfo':
				if (event.data.playTime) {
					$('#play_time').html(event.data.playTime);
				}
				if (event.data.uptime) {
					$('#uptime').html(event.data.uptime);
				}
				break;

			default:
				break;
		}
	}, false);

	$('.btn-close').on('click', function (e) {
		$('#wrap').fadeOut().hide()
		$.post('https://NR_PlayerList/hideList')
		visable = !visable;
		return false;
	})
});